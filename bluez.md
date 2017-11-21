# Compile Python Error  

```bash
configure:3954: checking whether the C compiler works
configure:3976: gcc -O2 -I/Volumes/workspace/lede/source/staging_dir/host/include -I/Volumes/workspace/lede/source/staging_dir/host/usr/include -I/Volumes/workspace/lede/source/staging_dir/hostpkg/include -I/Volumes/workspace/lede/source/staging_dir/target-mipsel_24kc_musl/host/include -I/Volumes/workspace/lede/source/staging_dir/host/include -I/Volumes/workspace/lede/source/staging_dir/host/usr/include -I/Volumes/workspace/lede/source/staging_dir/hostpkg/include -I/Volumes/workspace/lede/source/staging_dir/target-mipsel_24kc_musl/host/include -L/Volumes/workspace/lede/source/staging_dir/host/lib -L/Volumes/workspace/lede/source/staging_dir/host/usr/lib -L/Volumes/workspace/lede/source/staging_dir/hostpkg/lib -L/Volumes/workspace/lede/source/staging_dir/target-mipsel_24kc_musl/host/lib -Wl,--no-as-needed -lrt -L/Volumes/workspace/lede/source/staging_dir/hostpkg/lib -lssl -lcrypto conftest.c  >&5
ld: warning: directory not found for option '-L/Volumes/workspace/lede/source/staging_dir/host/usr/lib'
ld: warning: directory not found for option '-L/Volumes/workspace/lede/source/staging_dir/target-mipsel_24kc_musl/host/lib'
ld: unknown option: --no-as-needed
clang: error: linker command failed with exit code 1 (use -v to see invocation)
configure:3980: $? = 1
configure:4018: result: no
configure: failed program was:
| /* confdefs.h */
| #define _GNU_SOURCE 1
| #define _NETBSD_SOURCE 1
| #define __BSD_VISIBLE 1
| #define _BSD_TYPES 1
| #define _DARWIN_C_SOURCE 1
| /* end confdefs.h.  */
| 
| int
| main ()
| {
| 
|   ;
|   return 0;
| }
configure:4023: error: in `/Volumes/workspace/lede/source/build_dir/hostpkg/Python-2.7.14':
configure:4025: error: C compiler cannot create executables
See `config.log' for more details
```

# why

using -v command to find that librt is missing, I found following fix for Macos.

https://github.com/grpc/grpc/pull/1202/files

