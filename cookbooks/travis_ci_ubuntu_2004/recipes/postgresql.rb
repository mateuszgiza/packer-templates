apt_repository 'postgresql' do
  uri 'http://apt.postgresql.org/pub/repos/apt/'
  distribution 'focal-pgdg'
  components ['main']
  key 'https://www.postgresql.org/media/keys/ACCC4CF8.asc'
end

package 'postgresql'

execute 'change_pg_hba_conf' do
  command 'sudo line_numb=$(grep -n \'local\' /etc/postgresql/12/main/pg_hba.conf | grep \'postgres\' | grep \'peer\' | cut -d\')'
  command 'sudo sed -i \'\'$line_numb\'s/peer/trust/\' /etc/postgresql/12/main/pg_hba.conf'
  command 'sudo chmod -R 777 /var/log/postgresql'
end

apt_repository 'postgresql' do
  action :remove
end
