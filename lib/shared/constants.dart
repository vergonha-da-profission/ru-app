const BASE_URL = '192.168.31.91';
const WS_PORT = 3030;
const API_PORT = 3000;

const WEB_SOCKET_URL = 'ws://$BASE_URL:$WS_PORT';
const SERVER_URL = 'http://$BASE_URL:$API_PORT';
const ADD_FOUNDS_BANK_SILK = "$SERVER_URL/api/transaction/bank-silk";
const ADD_FOUNDS_URL = "$SERVER_URL/api/transaction/add";
