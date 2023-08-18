encrypt ()
{
# Use ascii armor
gpg -ac --no-options "$1"
}

bencrypt ()
{
# No ascii armor
# Encrypt binary data. jpegs/gifs/vobs/etc.
gpg -c --no-options "$1"
}

decrypt ()
{
gpg --no-options "$1"
}

pe ()
{
# Passphrase encryption program
# Created by Dave Crouse 01-13-2006
# Reads input from text editor and encrypts to screen.
clear
echo "         Passphrase Encryption Program";
echo "--------------------------------------------------"; echo "";
which $EDITOR &>/dev/null
 if [ $? != "0" ];
     then
     echo "It appears that you do not have a text editor set in your
.bashrc file.";
     echo "What editor would you like to use ? " ;
     read EDITOR ; echo "";
 fi
echo "Enter the name/comment for this message :"
read comment
$EDITOR passphraseencryption
gpg --armor --comment "$comment" --no-options --output
passphraseencryption.gpg --symmetric passphraseencryption
shred -u passphraseencryption ; clear
echo "Outputting passphrase encrypted message"; echo "" ; echo "" ;
cat passphraseencryption.gpg ; echo "" ; echo "" ;
shred -u passphraseencryption.gpg ;
read -p "Hit enter to exit" temp; clear
}

keys ()
{
# Opens up kgpg keymanager
kgpg -k
}

encryptfile ()
{
zenity --title="zcrypt: Select a file to encrypt" --file-selection > zcrypt
encryptthisfile=`cat zcrypt`;rm zcrypt
# Use ascii armor
#  --no-options (for NO gui usage)
gpg -acq --yes ${encryptthisfile}
zenity --info --title "File Encrypted" --text "$encryptthisfile has been
encrypted"
}

decryptfile ()
{
zenity --title="zcrypt: Select a file to decrypt" --file-selection > zcrypt
decryptthisfile=`cat zcrypt`;rm zcrypt
# NOTE: This will OVERWRITE existing files with the same name !!!
gpg --yes -q ${decryptthisfile}
zenity --info --title "File Decrypted" --text "$encryptthisfile has been
decrypted"
}
