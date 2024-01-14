# $Message\ Queue$

[TOC]

# Introduce

> Message queues and mailboxes are software-engineering components typically used for inter-process communication (IPC), or for inter-thread communication within the same process. They use a queue for messaging – the passing of control or of content.

A message queue is a communication mechanism used in distributed systems to enable asynchronous communication between components or systems. It provides a way for different parts of a system to exchange messages or data without the need for direct, synchronous interaction.

# Purpose

## Asynchronous

<img src="assets/640.png" alt="Image" style="zoom:67%;" />

## Traffic peak shaving

<img src="assets/640-1689329344087-3.png" alt="Image" style="zoom: 67%;" />

## Decoupling



# Models

## Point-to-Point Model

<img src="assets/95232a89849e51b2a785b04f23d3240.jpg" alt="95232a89849e51b2a785b04f23d3240" style="zoom:33%;" />

In the Point-to-Point model, each message can only be consumed by one consumer.



## Publish/Subscribe Model

<img src="assets/968f7290f52fe66e16225abc7536450.jpg" alt="968f7290f52fe66e16225abc7536450" style="zoom:33%;" />

In the Publish/Subscribe model, messages can be consumed by multiple consumers (subscribers) who have expressed interest in certain types of messages. Publishers categorize messages into different topics or channels, and subscribers choose which topics they want to receive messages from.

# Problems

## *How to ensure that messages are not lost?*

- Product messages
  - Acknowledgment Mechanism: Implement an acknowledgment mechanism between the message producer and the consumer. After a message is successfully processed, the consumer should send an acknowledgment back to the message queue, confirming that the message has been received and processed. If the acknowledgment is not received within a specified time, the message queue can attempt to resend the message or take other appropriate actions.

- Store message
  - Message Persistence: Store messages in a durable and persistent storage system, such as a database or disk, before they are delivered to consumers. This ensures that even if the message queue or the system experiences failures, the messages remain safe and can be recovered when the system is back online.
  - Redundancy and Replication: Employ redundant setups for message queue brokers and consumers. By replicating the message queue across multiple servers or data centers, you can ensure that even if one node fails, messages can still be processed by other nodes in the cluster.

- Consumer messages: After the consumer actually executes the business logic, we should send it to the Broker for successful consumption. This is the real consumption. So as long as we respond to `Broker` after the message business logic processing is completed, the message in the consumption phase will not be lost.

## *How to handle duplicate messages?*

- Message Deduplication: Implement message deduplication mechanisms within the message queue system. This involves assigning a unique identifier (message ID) to each message and checking for duplicate message IDs before processing. If a duplicate message ID is detected, the message can be discarded or ignored to avoid redundant processing.
- Idempotent Consumers: Design consumers (message processors) to be idempotent, meaning that processing the same message multiple times has the same effect as processing it once. In other words, the result of processing a message should not change, even if the message is processed multiple times.

## *How to ensure the order of messages?*

- Global order
  - Only one producer can send messages to a topic, and there can only be one queue (partition) inside a topic. Consumers must also be single-threaded to consume this queue. But in general, we don't need global ordering.

- Partially ordered
  - We can divide the Topic into the number of queues we need, send messages to fixed queues through specific strategies, and then each queue corresponds to a single-threaded consumer. In this way, part of the ordered requirements are completed, and the efficiency of message processing can be improved through the concurrency of the number of queues.

## *How to deal with message accumulation?*

Messages tend to pile up because the rate at which producers are producing doesn't match the rate at which consumers are consuming.

- Scale number of queues & consumers: Considering horizontal expansion, increase the number of queues and consumers of the Topic. Note that the number of queues must be increased, otherwise the newly added consumers will have nothing to consume. In a Topic, a queue will only be assigned to one consumer.

# Implementation Version

## [Kafka](./kafka.md)

