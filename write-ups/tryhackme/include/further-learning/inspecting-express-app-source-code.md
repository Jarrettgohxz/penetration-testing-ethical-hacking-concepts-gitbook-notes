# Inspecting Express app source code

From the remote shell session, I read through the Express source code to understand how it works, and to potentially find more vulnerabilities.&#x20;

### Exploiting Lodash \_.set() function

As shown before, there exists a POST `/recommend-activity/:friendId` route that uses the user input for direct object manipulation.  I attempted to exploit a potential prototype pollution vulnerability to manipulate the object prototype, but did not managed to find any.&#x20;

The following shows a code snippet of the mentioned route (`app.js`):

```javascript
app.post("/recommend-activity/:friendId", (req, res) => {
  if (!req.session.user) {
    return res.status(401).send("User not signed in");
  }

  const { friendId } = req.params;
  const { activityType, activityName } = req.body;

  const friend = friends.find((f) => f.id === parseInt(friendId));
  if (!friend) {
    console.log("Friend not found");
    return res.status(404).send("Friend not found");
  }

  try {
    _.set(friend, activityType, activityName);
        console.log("Session user:", req.session.user);
        if (req.session.user && req.session.user.id == friendId) {
                console.log("Session user:", req.session.user);
                req.session.user = friend;
        }
    console.log("Updated friend:", friend); // Log the updated friend object
  } catch (e) {
    console.log("Error in recommending activity:", e);
    return res.status(400).send("Error in recommending activity");
  }

  res.redirect(`/friend/${friendId}`);
});
```

We can see that the route uses the \_.set() function to modify the `friend` object.&#x20;

{% embed url="https://www.geeksforgeeks.org/javascript/lodash-_-set-method/" %}

This function has the following signature:&#x20;

```javascript
_.set(object, path, value)
```

&#x20;where the path value can be of the forms: `layer1.layer2` , `layer1.layer2[0].layer3` , etc. This means that we can also supply `__proto__.field`  to poison the object prototype.

