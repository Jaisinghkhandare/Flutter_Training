/*

import 'package:flutter_test/flutter_test.dart';
class StringCal
{
  static int add(String exp)
  {
    if(exp.length==0)
      {
        return 0;
      }
    List<int> numbers = exp.replaceAll('\n', ',').split(',').map((e) {
      print(">>> $e");
      return int.parse(e);
    }).toList();
    int ans=0;
    for(final int num in numbers)
      {
        ans+=num;
      }
    return ans;
  }
}
void main()
{
  test(
      'given and empty string'
          'when passed to add function'
          'then it returns 0',
          (){
        expect(StringCal.add(''), 0);
      }
  );
  test('given an string with one integer'
      'when passed to add fucntion'
      'then it returns the integer', ()
  {
    //expect(StringCal.add('0'), 0);
    expect(StringCal.add('1'), 1);
    expect(StringCal.add('11'), 11);
  });
  test('given an string with multipe integer '
    'when passed to add fucntion'
    'then it returns the sum of integer',(){
    expect(StringCal.add('1,2,3'), 6);
  });
  test('given an string with multipe integer with new /n line separted '
      'when passed to add fucntion'
      'then it returns the sum of integer',(){
    expect(StringCal.add('''1,2
    3'''), 6);
  });

}*/
