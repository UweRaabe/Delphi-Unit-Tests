# Welcome to the Delphi Unit Tests Project

This is a public, open source project for the Delphi community to build up a set of unit tests for Delphi's libraries.  

Delphi community members are encouraged to fork the repository, add tests, and create a pull request.  Embarcadero employees are particularly encouraged to add tests from the internal tests that are run with official Delphi builds.

The testing framework used for the is DUnitX.  It can be found here: [https://github.com/VSoftTechnologies/DUnitX](https://github.com/VSoftTechnologies/DUnitX) In order to run the tests, you need to create an environmental variable called $(DUNITX) that points to the base directory for DUnitX.  

Since a couple of releases DUnitX is an optional part of a Delphi installation and can be found as _DUnit Unit Testing Frameworks_ under the _Technology_ group of the installation screen. Using this feature removes the need for that environmental variable mentioned above.

The latest revision always supports the most recent Delphi version(s). You should be able to open the project group in that version and run all tests succeeding. We strongly suggest the use of [TestInsight](https://bitbucket.org/sglienke/testinsight/wiki/Home).

There might be some ignored tests, which are known to fail in the current version. These tests are automatically run on newer versions and hopefully give an incentive to fix them rather sooner than later.

Thus don't hesitate to write tests that fail! Actually we prefer tests that fail over those that succeed, without disregarding their value for regression testing.

