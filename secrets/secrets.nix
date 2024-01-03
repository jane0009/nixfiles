let
  hosts = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEP3lZBtAcrvQy7OVyGqVdCG7qn0vsgrjdAlnY8z9LMM" #shimmy
  ];
  cts = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIG2G/cWAlFDH0qTphAB3zdFtG+OoEg/WanPM4mb2PY1v" # ct 104, hillbilly
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDrVoPEg6mvQxgtjkvlbRv+WUuThk5iKDCnEU1oPMdny" # ct 107, sweetiebelle
  ];
  pubkeys =
    hosts
    ++ cts
    ++ [
      # unknown keys? need to go back and verify from: sparky, wsl
      "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQC22wM9CEgqxi4OOei6uAlDOZR6hOI381pe0cya4N3ETqO/Gv0R5exT+9fnoJ1ZFluhHVrvYECWRKQBBJxQTyhjcJRbPmLU4MFxl23cfH8Y9XNDW2lEPg8P8e0ZFED2wkXJcSXTcSRlsj7S9aVN2uxrxak89DfrHIZ1V6q/QIuVqS51cWhBzE7ifXdoE4TOFO2Aa6wyiO/xAWQQJURdL66BxmEYydZMWFXOUOCVEzBXrjTalG67bQpVKPKteCaXpb2t2Um3O9DO7nR8lRY+Nc4twElsOQPPF8sgddXiq7s7+cFl28mp0B+Fh7MmJlDIqT5MgkOln+Pu1i2mKBm2NUz0LqEucxU1Q//ux+9PrXpTRQ0rrAU1RwdnEDWlpufgvlJKliVxs5U2oOFDo1luXG1/kAyTwvfPT6YY7cXd3D7IxncDjB7yjiY54sZypmdxoAtpF4f+w0e0hc9Y2atdrVpbVmfrhtZqYkPvNJFPth4sVfx1RsqeexJArIyqQEuFLbB9YoN1saDMPT9RfhRQj66uzdg8mqP0Z5mU7zOHgntK0XvRv6B98Wpj3QPjP7MsKDVBSV4hO2wbocCTnvP+JuHlS8mz8Z6NYazy+drPKGkwNXV2GUre2SA8TTkgvCBg9fgRnefe47rZK79Sj2Sd4MkvmRO0iZHbX0gTnzHtzUKXVQ=="
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEXvFpl+7r/FjTKf4KNihYJbGCT0uuonB5nY0HE17Vnf"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFFxb+qd1D3km25cJf+RtnCp4DYJK1oq+Fr2WolRJs/j"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBqNc/koMlHRyrBZkGpbcZp+z3wpt9XNw+m3+B+MmIC+"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOT1X0F9sIDrsfQXDm7wYQL7sII71Ag3YRXCBmUUVRcc"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIHVQ7N83+XucFRM7eUbDSE3Z/pz3rmNBU53p560SsvWN"
    ];
in {
  "gitssh.age".publicKeys = pubkeys;
}
