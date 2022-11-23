job "hello-world" {
  datacenters = ["dc1"]

  type = "batch"

  group "primary" {
    count = 1

    task "say-hello" {
      driver = "exec"

      config {
        command = "echo"

        args = ["Hello", "world!"]
      }
    }
  }
}
