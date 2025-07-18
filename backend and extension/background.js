// Listener for when the Chrome extension is installed or updated
chrome.runtime.onInstalled.addListener(() => {
  console.log('Extension installed and running');
});

// Listener for receiving messages from other parts of the extension
chrome.runtime.onMessage.addListener((message, sender, sendResponse) => {
  if (message.type === 'keywordDetected') {
    console.log(`Keyword "${message.keyword}" detected in user search: ${message.query}`);

    // Send the detected keyword to the backend server
    fetch('http://localhost:3000/log-keyword', { // Change this to your deployed backend URL when ready
      method: 'POST',
      headers: {
        'Content-Type': 'application/json'
      },
      body: JSON.stringify([{
        keyword: message.keyword,
        query: message.query,
        url: message.url, // Assuming you are also sending the URL
        time: new Date().toISOString() // Logs the current time
      }])
    })
    .then(response => {
      if (!response.ok) {
        throw new Error('Network response was not ok');
      }
      return response.json();
    })
    .then(data => {
      console.log('Successfully sent to backend:', data);
    })
    .catch(error => {
      console.error('Error sending keyword data to backend:', error);
    });

    // Show a notification to inform the user
    chrome.notifications.create({
      type: 'basic',
      iconUrl: 'icon.png', // Path to your extension icon
      title: 'Keyword Detected',
      message: `The keyword "${message.keyword}" was found in the user’s search: "${message.query}"`,
      priority: 2
    });
  }
});

// Optional: Notifications on detection
chrome.notifications.onClicked.addListener(() => {
  console.log('Notification clicked');
});
