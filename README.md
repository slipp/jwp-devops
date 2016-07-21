## 실행
* ansible-playbook server.yml -i hosts --ask-become-pass

## ansible로 ubuntu에 mysql 설치하는 도중 에러 발생하는 경우
* http://egloos.zum.com/zzinggu/v/3097108
  * sudo rm /etc/apparmor.d/usr.sbin.mysqld