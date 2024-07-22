function fn() {

  var config = {
    baseUrl: "https://restful-booker.herokuapp.com/"
  };

  karate.log('karate-config.js is executed');
  karate.log('Base URL:', config.baseUrl);

  return config;
}
