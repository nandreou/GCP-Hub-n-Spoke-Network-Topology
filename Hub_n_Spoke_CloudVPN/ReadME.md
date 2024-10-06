# Network Architecture Overview

## Table of Contents
- [Introduction](#introduction)
- [Key Components](#key-components)
  - [Internet VPC](#internet-vpc)
  - [Transit VPC](#transit-vpc)
  - [NVA Instance Groups](#nva-instance-groups)
  - [VPCs (PRD, STAGING, DEV)](#vpcs-prd-staging-dev)
  - [Dynamic BGP Routes](#dynamic-bgp-routes)
  - [On-Premise Interconnect](#on-premise-interconnect)
- [Routing Overview](#routing-overview)
- [Policy-Based Routes](#policy-based-routes)
- [Hub VPCs Notes](#hub-vpcs-notes)
- [Conclusion](#conclusion)

## Introduction
This document provides an overview of a cloud-based Hub 'n' Spoke type network architecture for a hybrid multi-region deployment. The architecture integrates cloud resources with on-premise networks and features multiple VPCs (Virtual Private Clouds). The setup supports high availability, secure communication, and load balancing across different environments (PRD, STAGING, and DEV).

## Key Components

### Internet VPC
- **Purpose**: Facilitates outbound and inbound traffic from the internet.
- **Components**: 
  - Cloud NAT for handling outbound traffic
  - Load balancer for managing incoming requests
- **Connected to**: 
  - NVA Instance Group Region A (NIC0) 
  - Transit VPC via secondary subnets

### Transit VPC
- **Purpose**: Acts as the central routing hub for communication between on-premise, internet, and cloud VPCs.
- **Components**: 
  - Cloud Router
  - Load Balancer
- **Connected to**: 
  - NVA Instance Group Region A (NIC4)
  - NVA Instance Group Region B (NIC4)
  - On-Premise Interconnect

### NVA Instance Groups
- **Regions**: 
  - Region A
  - Region B
- **Purpose**: These Compute Engine instances serve as Network Virtual Appliances (NVA) for handling traffic between various VPCs.
- **NICs**:
  - NIC0: Internet connection
  - NIC1, NIC2, NIC3: Connected to different VPC environments (PRD, STAGING, DEV)
  - NIC4: Transit VPC connection
- **Function**: Provides segmentation for different environments and routes traffic based on policies.

### VPCs (PRD, STAGING, DEV)
- **Purpose**: 
  - PRD: Production environment
  - STAGING: Pre-production or testing environment
  - DEV: Development environment
- **Components**: 
  - Load Balancers
  - Cloud VPN for secure communication across environments
  - Cloud Routers for dynamic BGP routing
- **Connected to**: 
  - NVA Instance Groups via NIC1, NIC2, and NIC3

### Dynamic BGP Routes
- **Purpose**: Enables dynamic routing for traffic between different hubs-spokes using BGP (Border Gateway Protocol).
- **Setup**: 
  - PRD, STAGING, and DEV VPCs have spokes in Region A and Region B.
  - Each spoke connects back to the central VPC and resources via Cloud VPN tunnels (RegA and RegB).

### On-Premise Interconnect
- **Purpose**: Establishes a private and secure connection between on-premise resources and the cloud infrastructure.
- **Connected to**: Transit VPC for routing traffic to various cloud environments (PRD, STAGING, DEV) and vice versa.

## Routing Overview
- Traffic is routed dynamically using BGP between cloud resources in different hubs-spokes and between on-premise and cloud environments.
- Policy-based routing is applied to handle specific traffic flows (see next section for details).
- The diagram defines two primary route categories:
  1. **Policy-Based Routes**: Direct traffic based on specific CIDR ranges.
  2. **Dynamic BGP Routes**: Dynamically adjust based on network conditions.

## Policy-Based Routes
These routes are defined with priorities and handle traffic in different cases:

- **Priority 1**: 
  - From: 0.0.0.0/0 (default route) to Network CIDR 
  - Tagged route for NVAs in order to skip the packet loop after NVA forwards packet to its destination. 
- **Priority 2**: 
  - Specific Network CIDR/Mask to 0.0.0.0/0
  - Tagged route for NVAs in order to skip the packet loop after NVA forwards packet to its destination.
- **Priority 3**: 
  - From: 0.0.0.0/0 (default route) to Network CIDR
  - Routes traffic to NVA instance group (Firewall) using an Intrernal Pass through load Balancer. This rules applies for inbound traffic and traffic inside the GCP infra (PRD,STAGING,DEV).
- **Priority 4**:
  - Specific Network CIDR/Mask to 0.0.0.0/0
  - Similar to prio 3 but applies from sending packets outside GCPs infra.
- **Priority 5**: 
  - Dynamic BGP Routes handle region-based routing between hubs-spokes (PRD, STAGING, DEV VPCs).

## Hub VPCs Notes
- Each environment (PRD, STAGING, DEV, TRANSIT, INTERNET) has two primary subnets in each region: RegA and RegB.
- VPN Gateways and Cloud Routers are set up for each region:
  - 2 VPN Gateways in RegA and RegB for redundancy.
  - 2 Cloud Routers for each VPC in RegA and RegB.

## Conclusion
This architecture provides a scalable, secure, and efficient cloud network environment capable of handling both internal and external traffic across multiple regions and environments. The use of Policy-Based Routing (PBR) and Dynamic BGP ensures that traffic is routed effectively and efficiently.
