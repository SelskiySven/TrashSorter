class Condition{
 SharedInt _var;
 int _equalTo, _greatherThen, _lessThen;
 boolean _not;
 Condition(SharedInt variable, int equalTo){
  _var=variable;
  _equalTo=equalTo;
  _greatherThen=Integer.MAX_VALUE;
  _lessThen=Integer.MIN_VALUE;
 }
 Condition(SharedInt variable, int greatherThen, int lessThen){
  _var=variable;
  _greatherThen=greatherThen;
  _lessThen=lessThen;
  _equalTo=lessThen-1;
 }
 Condition(SharedInt variable, int equalTo, int greatherThen, int lessThen, boolean not){
  _var=variable;
  _equalTo=equalTo;
  _greatherThen=greatherThen;
  _lessThen=lessThen;
  _not=not;
 }
 Condition not(){
  return new Condition(_var, _equalTo, _greatherThen, _lessThen, !_not); 
 }
 boolean check(){
  return ((_var.get()==_equalTo)||(_var.get()<=_lessThen && _var.get()>=_greatherThen))^_not; 
 }
}