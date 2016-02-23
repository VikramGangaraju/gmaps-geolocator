To compile and execute FlexUnit tests on the library, first checkout the library using Subversion:
```
mkdir gmaps-geolocator
cd gmaps-geolocator
svn checkout http://gmaps-geolocator.googlecode.com/svn/trunk/gmaps-geolocator
```
Then, build the test runner with Ant:
```
ant compile.tests
```

After the tests have compiled, you may view them by pointing your browser to the location of the tests.swf file.


---

NOTE: for more on how to build the library, see [Building](Building.md).