Metric server

<img width="636" alt="image" src="https://github.com/user-attachments/assets/3ac40870-d455-49e4-b305-17fd6c02b72b" />

Application.yml
<img width="632" alt="image" src="https://github.com/user-attachments/assets/b0f6a8b8-98a2-45c7-b11e-31e427539d4f" />

deploy HPA min 3 max 10 per:50%
kubectl autoscale deployment php-apache --cpu-percent=50 --min=1 --max=10
<img width="925" alt="image" src="https://github.com/user-attachments/assets/06aa5b2c-5ac4-41a2-b783-e8b82fa8a690" />

HPA deployed


<img width="660" alt="image" src="https://github.com/user-attachments/assets/f5a07119-9cf2-4164-92c8-f763a515919c" />

Stress test

kubectl run -i --tty load-generator --rm --image=busybox:1.28 --restart=Never -- /bin/sh -c "while sleep 0.01; do wget -q -O- http://php-apache; done"
![image](https://github.com/user-attachments/assets/1121db6b-cfaa-41c5-9187-6f7570e2c809)

Replicas incresed to 7
<img width="894" alt="image" src="https://github.com/user-attachments/assets/3afdb747-6ebb-4933-a2fb-e467da1e9fd8" />

evenly distributed and is stable
<img width="866" alt="image" src="https://github.com/user-attachments/assets/8ddec625-7999-4525-8b4b-fd7544679156" />
