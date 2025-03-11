# ChatGPT

> Adapted from NahamSec's video on YouTube: [https://www.youtube.com/watch?v=0lq-CokNjSI](https://www.youtube.com/watch?v=0lq-CokNjSI)&#x20;

## General format

1. Legitimacy statement
2. Task
3. Technical context
4. Output constraints
5. Knowledge boundaries
6. Success criteria

### 1. Legitimacy statement&#x20;

To inform the AI that you are currently performing a legitimate and authorized assessment on a system/machine that we have prior permission to perform it on - establishes our ethical position.

_**Examples**_

> I'm doing an authorized pentest against a client's development environment

> I am working on a CTF

### 2. Task

The task that we want the AI to perform.

_**Examples**_

> Generate 5 working XSS paylods based on the following criteria

### 3. Technical context

Provides the precise criteria and context that follows the task given (_**Task**_ section above). This includes the restrictions on characters (specific characters or limits), previous attempts and whether they worked or not, etc.

_**Examples**_

> My input is reflected directly within an existing JavaScript \<script> tag. I'm restricted from using these characters: .... Inputs can't exceed 100 characters. My previous attempts are: \<script>...\</script>, and the results were ....&#x20;

### 4. Output constraints

Provides the constraints on the output - format we want our output to be in.

_**Examples**_

> Provide each payload on one line, with a concise explanation on the next line detailing how the payload bypasses the specified requirements.

> Provide outputs in JSON format

> Provide the output in url-encoded format

### 5. Knowledge boundaries

Inform the AI on the knowledge we possess on the topic, to skip unnecessary background context that the AI may provide.

_**Examples**_

> I already understand the basics on reflected XSS concepts. Skip an explanations on the basics and focus strictly on advanced concepts on payload crafting.

### 6. Success criteria

What defines how we judge a good response from the AI.

_**Examples**_

> Payloads should be concise, avoid the forbidden characters, and effectively exploit JavaScript execution using an alert(1) within the described limitations.



## Useful tools

{% embed url="https://github.com/simonw/llm" %}
