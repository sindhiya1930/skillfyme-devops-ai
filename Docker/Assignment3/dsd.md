
Setting up a Docker Swarm cluster.
Deploying an etcd cluster as Calico's datastore.
Installing calico/node on each Swarm node to enable policy enforcement.
Developing three Go services (service-a, service-b, service-c).
Deploying these services on a Docker overlay network within the Swarm.
Defining and applying Calico Network Policies to control communication.
Verifying the policies.
docker run -d --name etcd-calico --publish 2379:2379 --publish 2380:2380 --mount type=volume,source=etcd-data,target=/etcd-data quay.io/coreos/etcd:v3.5.0 etcd --name etcd-0 --data-dir /etcd-data --initial-cluster-state new --initial-cluster-token etcd-cluster-1 --initial-advertise-peer-urls http://52.91.71.238:2380 --listen-peer-urls http://0.0.0.0:2380 --advertise-client-urls http://52.91.71.238:2379 --listen-client-urls http://0.0.0.0:2379 --initial-cluster etcd-0=http://52.91.71.238:2380
![image](https://github.com/user-attachments/assets/060c224b-fb4c-4f63-a83c-46c9a8d06d99)

  <img width="929" alt="image" src="https://github.com/user-attachments/assets/28cb61b8-d347-4939-9342-6a8e2260f776" />

  <img width="950" alt="image" src="https://github.com/user-attachments/assets/2d09e06f-d220-4ab5-9046-c021eb021d11" />

<img width="960" alt="image" src="https://github.com/user-attachments/assets/edfc9a79-6d4c-4e0c-a6d5-700ba9f9c7ad" />
docker logs calico
<img width="947" alt="{610000E5-8C59-4637-9336-ACEAFC426F63}" src="https://github.com/user-attachments/assets/41e2f686-7bf0-454c-ae28-1a38e6ce4957" />
testinh etcd
<img width="772" alt="{B761DFC1-54DB-49AC-8283-1C36095613EE}" src="https://github.com/user-attachments/assets/3289d6c9-e764-496f-808a-cd4270d6c2fd" />

create network
<img width="567" alt="{2333268B-8B21-478D-AEE0-D2A40E2301E8}" src="https://github.com/user-attachments/assets/2afafd9f-7d9f-4b47-8422-5cd4394e817b" />



