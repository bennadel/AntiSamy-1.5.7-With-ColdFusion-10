
# Running AntiSamy 1.5.7 In ColdFusion 10 Using JavaLoader 1.2

This repository demonstrates how to run [AntiSamy 1.5.7][antisamy] in ColdFusion 10 using
[JavaLoader 1.2][javaloader]. Of particular interest, the `index.cfm` page showcases the
use of the JavaLoader method, `.switchThreadContextClassLoader()`, which is required for
AntiSamy 1.5.7 in order to avoid Class Load errors like:

> org.apache.xerces.jaxp.DocumentBuilderFactoryImpl cannot be cast to
> javax.xml.parsers.DocumentBuilderFactory

Special thanks to [Matthew J. Clemente][matthewclemente] who inspired me to investigate
this with his post about [ColdFusion and an earlier version of AntiSamy](https://blog.mattclemente.com/2016/05/12/antisamy-javaloader-getsafehtml.html).


[antisamy]: https://github.com/nahsra/antisamy
[javaloader]: https://github.com/markmandel/JavaLoader
[matthewclemente]: https://blog.mattclemente.com
