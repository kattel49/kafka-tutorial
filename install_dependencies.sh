wget https://downloads.apache.org/kafka/3.3.1/kafka_2.12-3.3.1.tgz
tar -xvf kafka_2.12-3.3.1.tgz

KAFKA_DIR=kafka_2.12-3.3.1
IP_ADDR="18.198.23.59"

sudo yum install java-1.8.0-openjdk
echo "$(java -version)"
# term 1
#run zookeeper server
cd kafka_2.12-3.3.1
bin/zookeeper-server-start.sh config/zookeeper.properties

#term 2
#in a different terminal, increase the memory cap for kafka
export KAFKA_HEAP_OPTS="-Xmx256M -Xms128M"
#run kafka server
bin/server-start.sh config/server.properties

# make kafka available through ipv4 in the ec2 instance
# update the security group to allow access to few protocols to access the kafka server
# term 3
# creating a topic
cd kafka_2.12-3.3.1
bin/kafka_topics.sh --create --topic demo_test --bootstrap-server $IP_ADDR:9092 --replication-factor 1 --partitions 1
# creating a producer
bin/kafka-console-producer.sh --topic demo_test --bootstrap-server $IP_ADDR:9092

#term 4
#creating a consumer
bin/kafka-console-consumer.sh --topic demo_test --bootstrap-server $IP_ADDR:9092
