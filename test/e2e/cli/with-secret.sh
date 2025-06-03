SRC=$(cd $(dirname "$0"); pwd)
source "${SRC}/../include.sh"

cd $file_path/post_start_hook
rm with-secret.log || true

$pm2 kill
$pm2 start process.yaml --only with-secret --with-secret <<< "secret1234" > pm2-with-secret.log

sleep 1
grep "Enter startup secret:" pm2-with-secret.log > /dev/null
grep "secret: secret1234" with-secret.log > /dev/null
spec "should prompt for the secret and pass it to the post_start_hook"

rm with-secret.log

$pm2 restart process.yaml with-secret
sleep 1
grep "secret: null" with-secret.log > /dev/null
spec "should not prompt again and pass null for the secret to post_start_hook on restart "

$pm2 delete all
