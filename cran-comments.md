## Submission comments

Fixed issue that resulted in package being removed from CRAN:

> This creates and leaves behind a file test.png in /tmp during R CMD check --as-cran, in the \donttest part of the widget2png example (which is run by example()).
>
> This is a serious violation of the CRAN policy.

## Test environments

* local OS X install, R 4.1.0
* win-builder: oldrelease, release, devel
* GitHub Actions - (ubuntu-20.04): release, devel
* GitHub Actions (windows): release
* Github Actions (macOS): release

## R CMD check results

0 errors | 0 warnings | 0 notes
