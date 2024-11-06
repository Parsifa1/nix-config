{ pkgs }:
let
  gcc = pkgs.gcc14.cc;
  apple-sdk = pkgs.apple-sdk;
  CompileFlags = "
        - -I${gcc}/include
        - -I${gcc}/include/c++/14.2.0/
        - -I${gcc}/include/c++/14.2.0//backward
        - -I${gcc}/include/c++/14.2.0//aarch64-apple-darwin
        - -I${gcc}lib/gcc/aarch64-apple-darwin/14.2.0/include
        - -I${gcc}/lib/gcc/aarch64-apple-darwin/14.2.0/include-fixed
        - -I${apple-sdk}/Platforms/MacOSX.platform/Developer/SDKs/MacOSX.sdk/usr/include
        - -I${apple-sdk}/MacOSX.platform/Developer/SDKs/MacOSX.sdk/System/Library/Frameworks
  ";
in
''
  If:
    PathMatch: [.*\.cpp, .*\.cc, .*\.h, .*\.hpp]
  CompileFlags:
    Add:
      - -std=c++2b
''
+ CompileFlags
+ ''
  ---
  If:
    PathMatch: [.*\.c]
  CompileFlags:
    Add:
      - -std=c17
''
+ CompileFlags
