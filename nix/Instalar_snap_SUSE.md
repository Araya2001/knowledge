Instalar snap:

```
$ sudo zypper addrepo --refresh https://download.opensuse.org/repositories/system:/snappy/openSUSE_Tumbleweed snappy
$ sudo zypper --gpg-auto-import-keys refresh
$ sudo zypper dup --from snappy
$ sudo zypper install snapd
$ sudo systemctl enable --now snapd
$ sudo systemctl enable --now snapd.apparmor
```
