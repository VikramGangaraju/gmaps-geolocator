In order to build this library, please check it out using Subversion:
```
mkdir gmaps-geolocator
cd gmaps-geolocator
svn checkout http://gmaps-geolocator.googlecode.com/svn/trunk/gmaps-geolocator
```
and then build it using Ant:
```
ant build.release
# Or, if you want to debug it:
ant build.debug
```
A new SWC will now appear in the /bin directory, either gmaps-geolocator-{VERSION}.swc (for release builds) or gmaps-geolocator-{VERSION}-debug.swc (for debug builds).


---

NOTE: You must create a file named 'flex.properties' declaring a java-style property named "FLEX\_HOME" which points to your local Flex SDK directory like so:
```
FLEX_HOME = /home/username/flex/4.0.0.10485
```