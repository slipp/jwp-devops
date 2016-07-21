## 실행
* ansible-playbook server.yml -i hosts --ask-become-pass

## mysql
### mysql 기반 코드
* 이 저장소의 mysql 기반 코드는 https://github.com/geerlingguy/ansible-role-mysql를 복사해 추가했다.

### ansible로 ubuntu에 mysql 설치하는 도중 에러 발생하는 경우
* http://egloos.zum.com/zzinggu/v/3097108
  * sudo rm /etc/apparmor.d/usr.sbin.mysqld
* mysql 시작시 에러 나는 경우
  * sudo tail -500f /var/log/mysql.err
* http://dbadiaries.com/how-to-resize-mysql-innodb-log-files-without-errors
  * sudo rm -rf /var/lib/mysql/ib_log* 로 삭제 후 다시 실행하면 된다.