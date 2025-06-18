
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

docker image creation
service c <img width="943" alt="{07A57FFD-B138-4456-92ED-FAB0C420B689}" src="https://github.com/user-attachments/assets/a507cc59-50b3-4739-81ad-9e5535879a10" />
service a <img width="831" alt="{7BBEBE1E-601A-460F-B42E-70E244042DF7}" src="https://github.com/user-attachments/assets/53c38d7d-f556-4c78-a083-add7f96d3fe1" />
service b <img width="817" alt="{7026695F-D8DE-484F-9CEB-95FD58A8F355}" src="https://github.com/user-attachments/assets/fad7ccf2-c0fa-4d1e-ac41-aa9e6a0ae8be" />

docker images
<img width="642" alt="{E665AA04-1737-4D9E-97F7-A5F73D3D6091}" src="https://github.com/user-attachments/assets/3fdd4f38-738e-4769-9690-ea4a5506cb73" />


sokcer services 
<img width="846" alt="{D2BE8BE0-FA68-45A7-BC68-0CD895BD2C8B}" src="https://github.com/user-attachments/assets/36118a55-14ef-4b21-9bce-d1d591091b35" />

b: <img width="942" alt="{B2FD3C7C-8D50-4795-8634-ACA35BDE8E36}" src="https://github.com/user-attachments/assets/7e714292-ba9b-49dc-b967-78523f8f1240" />
c: <img width="952" alt="{7CAE5979-4353-42AE-9DE5-E08A812FD96C}" src="https://github.com/user-attachments/assets/60745a42-26c9-45cb-89fa-dd91ad18652b" />



docker deploy
<img width="773" alt="{CEFE4B40-8DF5-4322-A34E-5B378F41A515}" src="https://github.com/user-attachments/assets/af9d1d9b-3774-4ac6-93ea-77072ee7d77f" />

docke




