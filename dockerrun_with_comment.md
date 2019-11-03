```
{
  "AWSEBDockerrunVersion": 2,
  "containerDefinitions": [
    {
      "name": "client",
      "image": "sey1000/multi-client",
      // defined from docker-compose services
      // Also set in nginx
      "hostname": "client",
      // if this crashes, other containers shut down.
      // At least one needs to be marked essential
      "essential": false
    },
    {
      "name": "server",
      "image": "sey1000/multi-server",
      // from nginx
      "hostname": "api",
      "essential": false
    },
    {
      "name": "worker",
      "image": "sey1000/multi-worker",
      // "hostname": "worker",
      "essential": false
    },
    {
      "name": "nginx",
      "image": "sey1000/multi-nginx",
      // hostname is optional. Other services don't need to talk to nginx
      // "hostname": "nginx",
      "essential": true,
      "portmappings": [
        {
          "hostPort": 80,
          "containerPort": 80
        }
      ],
      // maps to "name"
      "links": ["client", "server"]
    }
  ]
}
```
