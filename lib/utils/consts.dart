// https://pokeapi.co/api/v2/pokemon
const BASE_API_URL = "https://pokeapi.co/api/v2";
// constant for page limit & timeout
mixin AppLimit {
  static const int DIO_TIME_OUT = 30000;
}

enum RequestState { LOADING, IDLE, ERROR, SUCCESS }
