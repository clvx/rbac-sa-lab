# Introduction

rbac-sa-lab is a lab to test _allowing ServiceAccounts in a hub namespace access other namespaces_.

## Architecture

    A hub namespace service account has desired access to targeted namespaces using 
    a RoleBinding object in the targeted namespaces that binds a desired clusterRole/Role.

    hub sa --views pods in--> target-1 namespace

## Dependencies

If you have Nix and direnv will install all the dependencies after `direnv allow`. If not, check [flake.nix](https://github.com/clvx/rbac-sa-lab/blob/master/flake.nix#L21) for list of dependencies.

## Usage

   make kind-up
   make bootstrap

   #Test scenarios 
   make create #attempts to create a pod in target-1 using hub-sa service account which has a edit grant permission.
   make view #attempts to create a pod in target-1 using hub-view-sa service account which has a view grant permission.
   make list #attempts to list a pod in target-1 using hub-view-sa service account which has a view grant permission.

