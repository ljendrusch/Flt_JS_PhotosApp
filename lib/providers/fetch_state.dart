enum FetchState {
  init, // no http request initiated
  loading, // http request made, no response yet
  success, // successful response (200) received
  error, // any error; connection timeout, 403, no internet connection, etc.
}
