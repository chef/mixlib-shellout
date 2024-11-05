# mixlib-shellout Changelog

<!-- latest_release -->
<!-- latest_release -->
<!-- release_rollup -->
<!-- release_rollup -->
<!-- latest_stable_release -->
## [v3.3.4](https://github.com/chef/mixlib-shellout/tree/v3.3.4) (2024-11-05)

#### Merged Pull Requests
- Fix quoting of command arguments in Target Mode [#251](https://github.com/chef/mixlib-shellout/pull/251) ([thheinen](https://github.com/thheinen))
<!-- latest_stable_release -->

## [v3.3.3](https://github.com/chef/mixlib-shellout/tree/v3.3.3) (2024-10-14)

## [v3.3.3](https://github.com/chef/mixlib-shellout/tree/v3.3.3) (2024-10-14)

#### Merged Pull Requests
- [Unix#run_command] Remove Ruby 1.8.7 check [#242](https://github.com/chef/mixlib-shellout/pull/242) ([dafyddcrosby](https://github.com/dafyddcrosby))
- [#239] Add execution time to Windows shellout object [#247](https://github.com/chef/mixlib-shellout/pull/247) ([dafyddcrosby](https://github.com/dafyddcrosby))
- Increase EPIPE test input size based on platform page size [#241](https://github.com/chef/mixlib-shellout/pull/241) ([matoro](https://github.com/matoro))
- Adjustments for Chef Target Mode [#243](https://github.com/chef/mixlib-shellout/pull/243) ([thheinen](https://github.com/thheinen))
- Migrate from Chefstyle to Cookstyle [#249](https://github.com/chef/mixlib-shellout/pull/249) ([dafyddcrosby](https://github.com/dafyddcrosby))
- Fix execution in target mode with cwd parameter given [#250](https://github.com/chef/mixlib-shellout/pull/250) ([thheinen](https://github.com/thheinen))
- Fix execution of multiline inputs to target mode; Improve error output [#248](https://github.com/chef/mixlib-shellout/pull/248) ([thheinen](https://github.com/thheinen))

## [v3.2.8](https://github.com/chef/mixlib-shellout/tree/v3.2.8) (2024-06-11)

#### Merged Pull Requests
- Keep ffi version below 1.17 [#244](https://github.com/chef/mixlib-shellout/pull/244) ([tpowell-progress](https://github.com/tpowell-progress))

## [v3.2.7](https://github.com/chef/mixlib-shellout/tree/v3.2.7) (2022-04-04)

## [v3.2.7](https://github.com/chef/mixlib-shellout/tree/v3.2.7) (2022-04-04)

#### Merged Pull Requests
- Loosen platform regex to allow 64 or 32 bit mingw [#234](https://github.com/chef/mixlib-shellout/pull/234) ([clintoncwolfe](https://github.com/clintoncwolfe))
- Hard Coding the gems in the gemfile to overcome a Ruby 3.1 bug [#235](https://github.com/chef/mixlib-shellout/pull/235) ([johnmccrae](https://github.com/johnmccrae))

## [v3.2.6](https://github.com/chef/mixlib-shellout/tree/v3.2.6) (2022-03-31)

#### Merged Pull Requests
- Loosen platform regex to allow 64 or 32 bit mingw [#234](https://github.com/chef/mixlib-shellout/pull/234) ([clintoncwolfe](https://github.com/clintoncwolfe))

## [v3.2.5](https://github.com/chef/mixlib-shellout/tree/v3.2.5) (2021-02-13)

#### Merged Pull Requests
- fix broken windows tests [#227](https://github.com/chef/mixlib-shellout/pull/227) ([mwrock](https://github.com/mwrock))
- Add Ruby 3 testing + cleanup deps [#228](https://github.com/chef/mixlib-shellout/pull/228) ([tas50](https://github.com/tas50))
- gemspec: add license metadata [#229](https://github.com/chef/mixlib-shellout/pull/229) ([priv-kweihmann](https://github.com/priv-kweihmann))

## [v3.2.2](https://github.com/chef/mixlib-shellout/tree/v3.2.2) (2020-11-16)

#### Merged Pull Requests
- Remove copyright dates [#225](https://github.com/chef/mixlib-shellout/pull/225) ([tas50](https://github.com/tas50))
- Cleanup deps and fix the failing spec helper loading of support files [#226](https://github.com/chef/mixlib-shellout/pull/226) ([tas50](https://github.com/tas50))

## [v3.2.0](https://github.com/chef/mixlib-shellout/tree/v3.2.0) (2020-11-12)

#### Merged Pull Requests
- Windows: fetch env variables for specified users [#224](https://github.com/chef/mixlib-shellout/pull/224) ([kapilchouhan99](https://github.com/kapilchouhan99))

## [v3.1.7](https://github.com/chef/mixlib-shellout/tree/v3.1.7) (2020-10-29)

#### Merged Pull Requests
- Loosen win32-process dep to resolve Ruby 3 deprecation warnings [#223](https://github.com/chef/mixlib-shellout/pull/223) ([tas50](https://github.com/tas50))

## [v3.1.6](https://github.com/chef/mixlib-shellout/tree/v3.1.6) (2020-09-10)

#### Merged Pull Requests
- Use __dir__ instead of __FILE__ [#220](https://github.com/chef/mixlib-shellout/pull/220) ([tas50](https://github.com/tas50))
- Simplify things a bit with &amp;. [#221](https://github.com/chef/mixlib-shellout/pull/221) ([tas50](https://github.com/tas50))

## [v3.1.4](https://github.com/chef/mixlib-shellout/tree/v3.1.4) (2020-08-13)

#### Merged Pull Requests
- Fix a few typos [#217](https://github.com/chef/mixlib-shellout/pull/217) ([tas50](https://github.com/tas50))
- Optimize requires for non-omnibus installs [#218](https://github.com/chef/mixlib-shellout/pull/218) ([tas50](https://github.com/tas50))

## [v3.1.2](https://github.com/chef/mixlib-shellout/tree/v3.1.2) (2020-07-24)

#### Merged Pull Requests
- convert helper to default_paths API [#216](https://github.com/chef/mixlib-shellout/pull/216) ([lamont-granquist](https://github.com/lamont-granquist))

## [v3.1.1](https://github.com/chef/mixlib-shellout/tree/v3.1.1) (2020-07-18)

## [v3.1.0](https://github.com/chef/mixlib-shellout/tree/v3.1.0) (2020-07-17)

#### Merged Pull Requests
- shellout_spec: make &quot;current user&quot; independent of the environment [#203](https://github.com/chef/mixlib-shellout/pull/203) ([terceiro](https://github.com/terceiro))
- Minor doc fixes [#205](https://github.com/chef/mixlib-shellout/pull/205) ([phiggins](https://github.com/phiggins))
- extracting shell_out helper to mixlib-shellout [#206](https://github.com/chef/mixlib-shellout/pull/206) ([lamont-granquist](https://github.com/lamont-granquist))
- Bumping minor version [#207](https://github.com/chef/mixlib-shellout/pull/207) ([lamont-granquist](https://github.com/lamont-granquist))
- Test on Ruby 2.7 final, update chefstyle, and other CI fixes [#208](https://github.com/chef/mixlib-shellout/pull/208) ([tas50](https://github.com/tas50))
- Bump minor for release [#210](https://github.com/chef/mixlib-shellout/pull/210) ([lamont-granquist](https://github.com/lamont-granquist))
- Bumping minor for release again, again. [#211](https://github.com/chef/mixlib-shellout/pull/211) ([lamont-granquist](https://github.com/lamont-granquist))

## [v3.0.9](https://github.com/chef/mixlib-shellout/tree/v3.0.9) (2019-12-30)

#### Merged Pull Requests
- Add Ruby 2.6/2.7 and Windows testing [#198](https://github.com/chef/mixlib-shellout/pull/198) ([tas50](https://github.com/tas50))
- Substitute require for require_relative [#199](https://github.com/chef/mixlib-shellout/pull/199) ([tas50](https://github.com/tas50))

## [3.0.7](https://github.com/chef/mixlib-shellout/tree/3.0.7) (2019-07-31)

#### Merged Pull Requests
- Add the actual BK pipeline config [#185](https://github.com/chef/mixlib-shellout/pull/185) ([tas50](https://github.com/tas50))
- Blinding applying chefstyle -a. [#191](https://github.com/chef/mixlib-shellout/pull/191) ([zenspider](https://github.com/zenspider))
- Fix return type of Process.create to be a ProcessInfo instance again. [#190](https://github.com/chef/mixlib-shellout/pull/190) ([zenspider](https://github.com/zenspider))

## [v3.0.4](https://github.com/chef/mixlib-shellout/tree/v3.0.4) (2019-06-07)

#### Merged Pull Requests
- update travis/appveyor, drop ruby 2.2 support, test on 2.6 [#176](https://github.com/chef/mixlib-shellout/pull/176) ([lamont-granquist](https://github.com/lamont-granquist))
- Misnamed parameter in README [#178](https://github.com/chef/mixlib-shellout/pull/178) ([martinisoft](https://github.com/martinisoft))
- Add new github templates and codeowners file [#179](https://github.com/chef/mixlib-shellout/pull/179) ([tas50](https://github.com/tas50))
- Add BuildKite pipeline [#184](https://github.com/chef/mixlib-shellout/pull/184) ([tas50](https://github.com/tas50))
- Support array args on windows WIP [#182](https://github.com/chef/mixlib-shellout/pull/182) ([lamont-granquist](https://github.com/lamont-granquist))
- Load and unload user profile as required [#177](https://github.com/chef/mixlib-shellout/pull/177) ([dayglojesus](https://github.com/dayglojesus))

## [v2.4.4](https://github.com/chef/mixlib-shellout/tree/v2.4.4) (2018-12-12)

#### Merged Pull Requests
- Have expeditor promote the windows gem as well [#172](https://github.com/chef/mixlib-shellout/pull/172) ([tas50](https://github.com/tas50))
- Don&#39;t ship the readme in the gem artifact [#173](https://github.com/chef/mixlib-shellout/pull/173) ([tas50](https://github.com/tas50))

## [v2.4.2](https://github.com/chef/mixlib-shellout/tree/v2.4.2) (2018-12-06)

#### Merged Pull Requests
- Test on ruby-head and Ruby 2.6 in Travis [#170](https://github.com/chef/mixlib-shellout/pull/170) ([tas50](https://github.com/tas50))
- Remove dev deps from the gemspec [#171](https://github.com/chef/mixlib-shellout/pull/171) ([tas50](https://github.com/tas50))

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