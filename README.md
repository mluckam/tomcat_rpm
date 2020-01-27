# Tomcat rpm
This is a maven module that will grab the desired version of tomcat from [maven] and create a distributable rpm with the following name:
```sh
tomact<major_version><minor_version>-<major_version>.<minor_version>.<revision_version>.rpm
````

This rpm will be signed by the gpg secret key in the secret keyring referenced in the maven conifguration "signing.keyring.file" in the tomcat-parent pom.

Installation will place tomcat in the /opt/tomcat directory.  The only change made to the tomcat archive is that the setenv.d will be used instead of the sentenv.sh to store application environment variables.  This way each application can have its own file.

## How to Build

Update the version number to the desired tomcat version
````sh
mvn versions:set --define newVersion=<tomcat_version> \
--define processDependencies=false \
--define processParent=true \
--file tomcat-parent/pom.xml
````
build the project
````sh
mvn clean package
````


## Create gpg secret key and secret keyring
requires gnugpg < 2.1
since GnuPG 2.1 secret keys are no longer stored in a secret keyring see [release notes] 
```sh
gpg --full-generate-key
gpg --list-secret-keys
gpg --list-secret-keys --secret-keyring=test-secret-keyring.gpg
````
Below is the output from the above command with '2F3ECCB' being the key_id
```sh
/home/vagrant/.gnupg/test-secret-keyring.gpg
--------------------------------------------
sec   4096R/2F3ECCBD 2020-01-24
uid                  Test User (This is for testing purposes only) <test@user.com>
````
export secret key and generate a secret keyring
````sh
gpg --export-secret-keys <key_id> > private.key
gpg --no-default-keyring --secret-keyring=test-secret-keyring.gpg --allow-secret-key-import --import ./private.key
````

   [maven]: <https://mvnrepository.com/artifact/org.apache.tomcat/tomcat>
   [release notes]: <https://www.gnupg.org/faq/whats-new-in-2.1.html>
