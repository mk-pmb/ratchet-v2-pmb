
<!--#echo json="package.json" key="name" underline="=" -->
ratchet-v2-pmb
==============
<!--/#echo -->

<!--#echo json="package.json" key="description" -->
The dist/ folder of the ratchet framework, and scripts for publishing it to
npm.
<!--/#echo -->


* [Ratchet Homepage](http://goratchet.com/)
* [Ratchet on GitHub](https://github.com/twbs/ratchet)
* [ratchet.min.js][ghp-min-js] and [ratchet.min.css][ghp-min-css]
  on this repo's GitHub pages


In order to be able to fix this package independent from ratchet versioning,
I'll decimally shift-left the patch version:

| Version of…   | major | minor | patch                |
|:------------- |:-----:|:-----:|:--------------------:|
| Ratchet       |   2   |   m   |   p                  |
| This package  |   2   |   m   | (p * 1000) + release |

<!--#toc stop="scan" -->


&nbsp;


  [ghp-min-js]: https://mk-pmb.github.io/ratchet-v2-pmb/js/ratchet.min.js
  [ghp-min-css]: https://mk-pmb.github.io/ratchet-v2-pmb/css/ratchet.min.css

License
-------

MIT, &copy; Connor Sears and other contributors
