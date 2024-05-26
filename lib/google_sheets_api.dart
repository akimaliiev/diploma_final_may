import 'package:gsheets/gsheets.dart';

class GoogleSheetsApi{
  
//credentials for gsheets
  static const _credentials = r'''
{
  "type": "service_account",
  "project_id": "diploma-auth-af731",
  "private_key_id": "3ff97dbd8c3cb78ca2305ab2830a2a3bf498b7d4",
  "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvgIBADANBgkqhkiG9w0BAQEFAASCBKgwggSkAgEAAoIBAQDx1vHHMz+kMqep\nE/AFhDq2vzYCnt86Rv2CqIpGd0RyObUj3uz+Qerr69M7l7D/GMbRCpS+zKwA6oLU\n+mGsj+N1F5n2ND16B34TzNThOCGb1vpE4Kea1bTdhs04C/YF6ZRzTIb5a3Po8euL\nxk3AKVlKDX8lsbYlhoIac7j6NrkgBx4GcDYLIR5aDUMol5Uhu8OtFXXPyXW4bn9+\n8FzUuNAYyySKGZ3KjQ5Yfb3dKbgyBhsQz584sP92NdvpMDhkvOn0wDFHw3r8pYLV\nR7Qh9VVauf0CO2j73j9APTBftEokFb23L4ZRgrLDcAA1eiW8VuW/Tp5FvaRbSc0H\nl6Xe0QmpAgMBAAECggEAAOyj5vGEtEF3T5eiarr7KHipoa/uxX/A909im+tXySH8\nVcND36Lr3XP8zjUBua/kDqd+Mw6AN86tqle8qNax9WAeOAkyFPXTXwsA401+H2Te\ndwXuzhI0C0a5IRY2ngYrCZfIykpFWqYWEuYypOHjk/tiOYgo3JLbi3NWySoNYhhy\n91o+uGi6MAUYOMu5W2pVGs2Q6lQORnDStjHkX8hZg10/AJaSRWl4pH0BHLhdY8+I\nE2FL5GMuonxYJu7cA5D7UjfTgbo3mUwnLzq2nQ45Gt5mc33HBO613Yo1SiXE8vhr\n6rsZ1Uk8f4uzD9/hrlovfPkiHzAmU5ZjuVsen/18yQKBgQD+rJVAikGnsSVyi175\nu3eSRjqkJ0vS+I5JGUWwzMYaZGOXPe1vrHKZ+jBIDxcrFZL/Fxol2GwPNcjf50id\nxozR8G3Yjy3rBNhxR8+iGXC+kZYSBNZSAGIU9nFLC2QFNpSXDxl8IJYyKyQy6PIU\n+fMI+Gz7ydziTneE2fLG9e5J1QKBgQDzGUGXU3MJkZ+FGfR9nsqPSIhUEMKDEo3K\nDSlS8Tx/1VpnJMCB71tLBT4HNEqldXCrpozUJGivL5W4ySyj5DJAsOGzns51YdO6\nzne4VlqGVy/av9gMjF45XKCjDLdjV2i9PUYBnraPIAOk2ybsPawSx0Sq15OV3RRk\nB/3M6cr2hQKBgQDrxNpn5ZbiqB0C7gP/Lo6D3IBtd/O6XGFdSwg5pVnBFS8d1Tb7\nK6rs4bHRBCduu4pangiXAMUJT8Gnh3aymh3EPdFzqxnXeaTnOpP+fY7i3eUQyWmg\ngLpMrdo0n1b5fI4TSudNAt4Jk+bvOrjisoNMyrAaaccTu5DqbNtVVlhEAQKBgQDx\nBm+D7Bc4u4tf2nYQPuoy2gVg5CUW88RlOltogwoq7Ixvi37a1Ui8vvvbBLumBSSq\n67zhcR/h4doelkeOT2iLv1RoVOH6e/4DT0ZgHC4w2Cz4RBGfj2S0luQmBSumcTnF\ntwS8AnKawXEbeLXEsPj0vWGVyZvokIPxEgNPsdWsSQKBgFwTpkI7FyG07X1rOMSC\ntVmqI8D0L4VR752lH3DMS86UotJrxSo+oJOaq/esUJE1WKAVT+GAiC/L6j3qebNx\nCMq1r0wTRvJpLRriwYj8xdrtRQHPLvRYN9h085+Dus7AfOdS4lY0z7Zdcj0XqWx1\n2Wks148BxHfsy8PXANKPdcG9\n-----END PRIVATE KEY-----\n",
  "client_email": "diploma-gsheets@diploma-auth-af731.iam.gserviceaccount.com",
  "client_id": "101269218256535239681",
  "auth_uri": "https://accounts.google.com/o/oauth2/auth",
  "token_uri": "https://oauth2.googleapis.com/token",
  "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
  "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/diploma-gsheets%40diploma-auth-af731.iam.gserviceaccount.com",
  "universe_domain": "googleapis.com"
}

    ''';
  static const _spreadsheetId = '1WgppSJbepP9hUlm_PDjmNkgVqXNrXadzsxut44JVkQU';
  static final _gsheets = GSheets(_credentials);
  static Worksheet? _worksheet;

  static int numberOfTransactions = 0;
  static List<List<dynamic>> currentTransactions = [];
  static bool loading = true;

  Future init() async{
    final ss =  await _gsheets.spreadsheet(_spreadsheetId);
    _worksheet = ss.worksheetByTitle('Worksheet');
    countRows();
  }
//count the number of notes
  static Future countRows() async{
    while((await _worksheet!.values.value(column: 1, row: numberOfTransactions+1)) != ''){
      numberOfTransactions++;
    }
    loadTransactions();
  }


  static Future loadTransactions() async{
    if(_worksheet == null) return;

    for (int i=1;i<numberOfTransactions; i++){
      final String transactionName = await _worksheet!.values.value(column:1, row: i+1);
      final String transactionAmount = await _worksheet!.values.value(column:2, row: i+1);
      final String transactionType = await _worksheet!.values.value(column:3, row: i+1);

      if(currentTransactions.length < numberOfTransactions){
        currentTransactions.add([
          transactionName,
          transactionAmount,
          transactionType,
        ]);
      }
    }
    loading = false;
  }

  static Future insert(String name, String amount, bool _isIncome) async{
    if(_worksheet == null) return;
    numberOfTransactions++;
    currentTransactions.add([
      name,
      amount,
      _isIncome == true ? 'income' : 'expense',
    ]);
    await _worksheet!.values.appendRow([
      name,
      amount,
      _isIncome == true ? 'income':'expense'
    ]);
  }
  static Future update(int rowIndex, String name, String amount, bool isIncome) async {
  if (_worksheet == null) return;
  if (rowIndex > 0 && rowIndex <= currentTransactions.length) {
    currentTransactions[rowIndex - 1] = [
      name,
      amount,
      isIncome ? 'income' : 'expense',
    ];
  }
  await _worksheet!.values.insertRow(
    rowIndex,
    [
      name,
      amount,
      isIncome ? 'income' : 'expense'
    ],
  );
}
static Future delete(int rowIndex) async {
  if (_worksheet == null || rowIndex <= 0 || rowIndex > currentTransactions.length) return;

  currentTransactions.removeAt(rowIndex - 1);

  // Remove the row from the worksheet
  await _worksheet!.deleteRow(rowIndex);
}


  static double calculateIncome(){
    double totalIncome = 0;
    for(int i = 0; i< currentTransactions.length;i++){
      if(currentTransactions[i][2] == 'income'){
        totalIncome += double.parse(currentTransactions[i][1]);
      }
    }
    return totalIncome;
  }
  static double calculateExpense(){
    double totalExpense = 0;
    for(int i = 0; i< currentTransactions.length;i++){
      if(currentTransactions[i][2] == 'expense'){
        totalExpense += double.parse(currentTransactions[i][1]);
      }
    }
    return totalExpense;
  }
}