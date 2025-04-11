
class FetchData{}
class Loading extends FetchData{}
class Loaded extends FetchData{
  List ? data;
  Loaded(this.data);
}
class Error extends FetchData{
}