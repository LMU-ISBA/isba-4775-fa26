# Why this matters

One section per class session, added as the semester goes.

In class I name two or three of these out loud and move on, because class time is
better spent on the material than on a list. This is the list. Read it when you
are wondering why a session was worth your afternoon, or when somebody asks you
what this course is actually for.

Three questions run through all of it:

- **Professional life.** When will I actually do this?
- **Employability.** Will this help me get hired?
- **Being a better contributor.** What does this let me add to a team?

They are not the same question, and most sessions are stronger on one than the
others. Where a session is honestly narrow, it says so.

---

## Session 01 — What is a network

*Tue 9/1*

### Professional life

- Your first week at any job is somebody handing you a laptop and a VPN client
  and saying "get on the network." How smoothly that goes depends on whether you
  know what the parts are.
- "It works on my machine" is a claim about one path through a system with dozens
  of parts. Knowing the parts is how you find out whose machine it does not work
  on, and why.
- Every incident call opens with "what changed, and where." That question is
  unanswerable without a map of the thing.
- Somebody will ask you whether the office needs better wifi or a better internet
  connection. Those are different products, different vendors, and different
  budgets, and they will ask you because you are the technical person in the room.
- Working from home, from a hotel, and from a client site each fail differently.
  The difference is which part of the picture you are missing.

### Employability

- "What is the difference between a switch and a router" is still a real
  entry-level screening question. So is "walk me through your home network."
- Cloud, DevOps, platform, security, and support roles all assume this as
  background rather than teaching it. It is the floor, not a specialization.
- Every certification any of those roles asks for opens with this material.

### Being a better contributor

- You will sit in rooms where somebody says VLAN, subnet, or NAT. Following that
  conversation is the difference between participating in it and waiting for it
  to end.
- You will work with vendors and IT departments who are sometimes wrong. You
  cannot notice that without the vocabulary.
- "Is this system isolated from that one" gets asked constantly in any regulated
  industry, and it is a network question.
- The person who can say "that is not a code problem, that is the network" saves
  the team an afternoon. It is usually not the most senior person in the room.

### What AI does not do for you here

An AI will answer every factual question in this session instantly and mostly
correctly. What it will not do is tell you which of the twenty parts to look at
first, in your third week, on a call, when the only information you have is that
it works for you and not for the Chicago office. Knowing the parts is what makes
the AI's answer checkable.

---

## Session 02 — One request, end to end

*Thu 9/3*

### Professional life

- Every deployment you ever do ends with somebody asking "is it live?" The answer
  is a walk down this chain, or it is refreshing the page and hoping.
- On-call and incident triage runs in this order. Name resolves, connection
  opens, certificate valid, request answered. The first one that fails is where
  you are, and you stop looking anywhere else.
- "The site is slow" is at least three different problems — resolution, the
  handshake, or the application itself. Different fixes, different owners.
- Moving a site to a new host is a DNS change with a cache behind it. Done
  without understanding TTL, it takes the site down for a day.
- Email that silently stops being delivered is SPF, DKIM, and DMARC, which are
  all DNS records. Exercise 06 is this material wearing a different hat.
- An API that returns 401, then 403, then 429, then 502 is telling you which end
  to look at each time. Most people never learn to read that.

### Employability

- "What happens when you type a URL and press enter" is the most-asked systems
  question in technical interviewing, and has been for about twenty years. It is
  asked because there is no correct depth — how far you get before you run out is
  the measurement.
- "What is the difference between a 502 and a 504" is a real follow-up to it.
- Cloud, platform, and reliability roles assume all of this. It is what an
  interview moves past quickly in order to reach the harder question, and moving
  past it is only possible if you have it.

### Being a better contributor

- The person who says "that is DNS, not the app" saves the team an afternoon, and
  it is rarely the most senior person in the room.
- Being able to read a certificate chain lets you tell a vendor their
  configuration is wrong, with evidence, instead of filing a ticket and waiting.
- Knowing that the name of the site you are visiting is visible even when the
  traffic is encrypted is the kind of fact that changes a privacy conversation.
- Understanding managed platforms against raw infrastructure is what makes you
  useful in a build-versus-buy meeting instead of a spectator in one.

### What AI does not do for you here

An AI can explain every stage of this chain better than most textbooks. What it
cannot do is look at your system on a Monday morning and tell you which stage
failed. That takes running the commands, reading what actually came back, and
knowing which two points in the chain to compare. That gap is what the session is
built around.
