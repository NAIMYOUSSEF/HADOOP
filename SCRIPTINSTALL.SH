#!/bin/bash
tar -xvf hadoop-2.7.3.tar.gz


#download hadoop, untar, put in /usr/local
#cd /tmp
#wget "$MIRROR/$VERSION".tar.gz
#tar -xzf "$VERSION".tar.gz
#mv  $VERSION /usr/local
#rm "$VERSION".tar.gz

# create user and group
#addgroup hadoop
#useradd  -G hadoop hduser -s /bin/bash -m

# app folder; who uses this ????
#mkdir -p /app/hadoop/tmp
#chown -R hduser.hadoop /app/hadoop/tmp
#chmod 750 /app/hadoop/tmp

#modify hadoop-env
cd /usr/local/$VERSION/conf
echo "export JAVA_HOME=/usr" >> hadoop-env.sh
echo "export HADOOP_OPTS=-Djava.net.preferIPv4Stack=true" >> hadoop-env.sh


#get configuration files
rm core-site.xml
wget https://raw.github.com/NAIMYOUSSEF/scripts/core-site.xml
rm mapred-site.xml
wget https://raw.github.com/NAIMYOUSSEF/scripts/mapred-site.xml
rm hdfs-site.xml
wget https://raw.github.com/NAIMYOUSSEF/scripts/hdfs-site.xml

# chmod, symbolic links
cd /usr/local
ln -s $VERSION hadoop
chown -R hduser.hadoop $VERSION
chown hduser.hadoop $VERSION

su - hduser -c "/usr/local/hadoop/bin/hadoop namenode -format"

#ssh stuff
su - hduser -c "echo | ssh-keygen -t rsa -P \"\""
cat /home/hduser/.ssh/id_rsa.pub >> /home/hduser/.ssh/authorized_keys
su - hduser -c "ssh -o StrictHostKeyChecking=no localhost echo "# login once, to add to known hosts

su - hduser -c "/usr/local/hadoop/bin/hadoop namenode -format"
