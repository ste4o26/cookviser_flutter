const String DOMAIN_URL = "http://localhost:8080";

// TODO make use of the enums instead of hard coded strings
enum Routes {
  home("/"),
  cuisines("/cuisines"),
  recipes("/all_recipes"),
  signIn("/sign_in"),
  signUp("/sign_up");

  final String name;
  const Routes(this.name);
}