# mixlib-shellout Changelog

<!-- latest_release 2.4.3 -->
## [v2.4.3](https://github.com/chef/mixlib-shellout/tree/v2.4.3) (2018-12-07)

#### Merged Pull Requests
- Have expeditor promote the windows gem as well [#172](https://github.com/chef/mixlib-shellout/pull/172) ([tas50](https://github.com/tas50))
<!-- latest_release -->
<!-- release_rollup since=2.4.2 -->
### Changes not yet released to rubygems.org

#### Merged Pull Requests
- Have expeditor promote the windows gem as well [#172](https://github.com/chef/mixlib-shellout/pull/172) ([tas50](https://github.com/tas50)) <!-- 2.4.3 -->
<!-- release_rollup -->
<!-- latest_stable_release -->
## [v2.4.2](https://github.com/chef/mixlib-shellout/tree/v2.4.2) (2018-12-06)

#### Merged Pull Requests
- Test on ruby-head and Ruby 2.6 in Travis [#170](https://github.com/chef/mixlib-shellout/pull/170) ([tas50](https://github.com/tas50))
- Remove dev deps from the gemspec [#171](https://github.com/chef/mixlib-shellout/pull/171) ([tas50](https://github.com/tas50))
<!-- latest_stable_release -->

## Release 2.4.0

- Added username and password validation for elevated option on Windows
- Added support for setting sensitive so that potentially sensitive output is suppressed

## Release 2.3.2

- Fix bad method call in Windows Process module

## Release 2.3.1

- Make Mixlib::ShellOut::EmptyWindowsCommand inherit from ShellCommandFailed

## Release 2.3.0

- Add support for 'elevated' option on Windows, which logs on as batch server which is not affected by User Account Control (UAC)

## Release 2.2.6

- Fix regression introduced in 2.2.2 by changing `CreateProcessAsUserW` to use a `:int` instead of `:bool` for the `inherit` flag to fix `shell_out` on windows from a service context

## Release 2.2.5

- [**tschuy**:](https://github.com/tschuy) convert environment hash keys to strings

## Release 2.2.3

- Kill all child processes on Windows when a command times out.

## Release 2.2.2

- Ship gemspec and Gemfiles to facilitate testing.
- Fix #111 by pulling in an updated version of win-32/process and correctly patching Process::create.
- Kill all child processes on Windows when a command times out.

## Release 2.2.1

- Fix executable resolution on Windows when a directory exists with the same name as the command to run

## Release 2.2.0

- Remove windows-pr dependency

## Release 2.1.0

- [**BackSlasher**:](https://github.com/BackSlasher) `login` flag now correctly does the magic on unix to simulate a login shell for a user (secondary groups, environment variables, set primary group and generally emulate `su -`).
- went back to setsid() to drop the controlling tty, fixed old AIX issue with getpgid() via avoiding calling getpgid().
- converted specs to rspec3

## Release: 2.0.1

- add buffering to the child process status pipe to fix chef-client deadlocks
- fix timeouts on Windows

## Release: 2.0.0

- remove `LC_ALL=C` default setting, consumers should now set this if they still need it.
- Change the minimum required version of Ruby to >= 1.9.3.

## Release: 1.6.0

- [**Steven Proctor**:](https://github.com/stevenproctor) Updated link to posix-spawn in README.md.
- [**Akshay Karle**:](https://github.com/akshaykarle) Added the functionality to reflect $stderr when using live_stream.
- [**Tyler Cipriani**:](https://github.com/thcipriani) Fixed typos in the code.
- [**Max Lincoln**](https://github.com/maxlinc): Support separate live stream for stderr.