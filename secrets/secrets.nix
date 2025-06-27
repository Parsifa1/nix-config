let
  mac = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIIpOQirGxMfUl3F8KQxjzDZg0POSIpeNk5ayZQvugQOm li.aldric@gmail.com";
  win = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDgb0NbVy2X/Hbn0/MOJ49TJwwJ1DJp4Y+itBEOJvKgHzKLZyoOC5MhdLgy+6sIeaNXEjVcRTAhvKWJISVGEhx6LjuLDEhLpn+7KwZOa//iqoE4WImw8xfbqZDWvGgc+ZOM7r0JpjzXSa23SKdhHD/iZYS6YW7EeOLEbcDSxeKCIdzEff7m/7khUp34Cuw6IOV7lNmHTO+oyyr26M/CtXNuDX4kTygL3D7y5xje/AFzTXD5lwWIEIQi0lKwFPao9XSnK05Qlaj3mg2pg/qlscRoxmZ3nIJtIrQKgIn+l/QLJyh3kwZmI+PWzN+aNmqnwGh6nJxLuGhlue2dCAZx1tkvGmfnZIZNV2bqn5fKhQO8zqAHDziYzCWYN9pk3G9tXSXGBbNiEKTQ1IWFAlayuCf3JLNhwwwE+rww41CxplasQ9pho/atrKaCWHxka+SDdg94SaMEPaA9U3e9CqO6G8gRHNFTnhowNZ3CQteG4BsU7UD0RCRASDBeF1SHECx+oEU= li.aldric@gmail.com";
  debian = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCcUX6n85AeHZdyS3/IjpEifHFEVEiQBh59l98cBKvmE2ucTiYTc41ML5C21Sd4OGy9/7TyAjcHQQIpVbPPczDa0Um1BUsh14cTfKcqZ4ajaRXzfUsp+g9p75ZBHT5Ul6T0iZFtizV1I7KsXYj3ZZr+k1CvUROvp1a8lpYy2xQDMLLHwZtPehDk0bCqfqCCF935+ubKu6Zm1ZIdRxpjoOcDTXeDgbcCfQPJhH/he1Z3eFbD9j1PEP9MRMhcEIKUI9LOh9JzN0xrD8HHF0cMUO/omfCq1xtqSFanE211F4IqOgwoq6RdaKYppOvTLOMgkhpEX6Tlph3vyHmt+CI/LrcMQPJQCnawq7bumsCym1+u9I9VFUuw/YWmKp9XrkE0n7iWUXgRc/y7vZ/KZ54DFX14yzl+CgRlJbA5eKHgJIjv7eoO3UoMTo0Ouv3DDl5KXoeIBC8702txeG/z/v/I/f33+gCiLJLEdp6VqLx5u0QOXGmSGxNGxLxIELmfnBzLnwE= parsifa1@debian";
  sub = [
    mac
    win
    debian
  ];
in
{
  "gemini.age".publicKeys = sub;
  "wakatime.age".publicKeys = sub;
  "sshconfig.age".publicKeys = sub;
  "github.age".publicKeys = sub;
}
