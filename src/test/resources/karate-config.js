function fn() {
  karate.configure('report', { showLog: true, showAllSteps: true });
  return {
    baseUrl: 'https://restful-booker.herokuapp.com/'
  };
}