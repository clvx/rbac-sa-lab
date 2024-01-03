# Introduction

rbac-sa-lab is a lab to test _allowing ServiceAccounts in a hub namespace access other namespaces_.

## Architecture

    A hub namespace service account has desired access to targeted namespaces using 
    a RoleBinding object in the targeted namespaces that binds a desired clusterRole/Role.

    hub sa --views pods in--> target-1 namespace


