let
  mac = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIIpOQirGxMfUl3F8KQxjzDZg0POSIpeNk5ayZQvugQOm li.aldric@gmail.com";
  win = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDgb0NbVy2X/Hbn0/MOJ49TJwwJ1DJp4Y+itBEOJvKgHzKLZyoOC5MhdLgy+6sIeaNXEjVcRTAhvKWJISVGEhx6LjuLDEhLpn+7KwZOa//iqoE4WImw8xfbqZDWvGgc+ZOM7r0JpjzXSa23SKdhHD/iZYS6YW7EeOLEbcDSxeKCIdzEff7m/7khUp34Cuw6IOV7lNmHTO+oyyr26M/CtXNuDX4kTygL3D7y5xje/AFzTXD5lwWIEIQi0lKwFPao9XSnK05Qlaj3mg2pg/qlscRoxmZ3nIJtIrQKgIn+l/QLJyh3kwZmI+PWzN+aNmqnwGh6nJxLuGhlue2dCAZx1tkvGmfnZIZNV2bqn5fKhQO8zqAHDziYzCWYN9pk3G9tXSXGBbNiEKTQ1IWFAlayuCf3JLNhwwwE+rww41CxplasQ9pho/atrKaCWHxka+SDdg94SaMEPaA9U3e9CqO6G8gRHNFTnhowNZ3CQteG4BsU7UD0RCRASDBeF1SHECx+oEU= li.aldric@gmail.com";
  sub = [
    mac
    win
  ];
in
{
  "wakatime.age".publicKeys = sub;
  "sshconfig.age".publicKeys = sub;
}
