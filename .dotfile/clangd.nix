{ pkgs, gcc }:
let
  header = gcc.cc;
  version = gcc.version;
  apple-sdk = pkgs.apple-sdk;
in
''
  If:
    PathMatch: [.*\.cpp, .*\.cc, .*\.h, .*\.hpp]
  CompileFlags:
    Add:
      - -std=c++2b
      - -I${header}/include
      - -I${header}/include/c++/${version}/
      - -I${header}/include/c++/${version}/backward
      - -I${header}/include/c++/${version}/aarch64-apple-darwin
      - -I${header}lib/gcc.cc/aarch64-apple-darwin/${version}/include
      - -I${header}/lib/gcc.cc/aarch64-apple-darwin/${version}/include-fixed
      - -I${apple-sdk}/Platforms/MacOSX.platform/Developer/SDKs/MacOSX.sdk/usr/include
      - -I${apple-sdk}/MacOSX.platform/Developer/SDKs/MacOSX.sdk/System/Library/Frameworks
  ---
  If:
    PathMatch: [.*\.c]
  CompileFlags:
    Add:
      - -std=c17
      - -I${header}/include
      - -I${header}/include/c++/${version}/
      - -I${header}/include/c++/${version}/backward
      - -I${header}/include/c++/${version}/aarch64-apple-darwin
      - -I${header}lib/gcc.cc/aarch64-apple-darwin/${version}/include
      - -I${header}/lib/gcc.cc/aarch64-apple-darwin/${version}/include-fixed
      - -I${apple-sdk}/Platforms/MacOSX.platform/Developer/SDKs/MacOSX.sdk/usr/include
      - -I${apple-sdk}/MacOSX.platform/Developer/SDKs/MacOSX.sdk/System/Library/Frameworks
''
