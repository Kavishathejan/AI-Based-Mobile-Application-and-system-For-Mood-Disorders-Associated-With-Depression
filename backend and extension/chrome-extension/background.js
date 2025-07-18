// Listener for when the Chrome extension is installed or updated
chrome.runtime.onInstalled.addListener(() => {
  console.log('Extension installed and running');
});

// Listener for receiving messages from content.js
chrome.runtime.onMessage.addListener((message, sender, sendResponse) => {
  console.log('Received message:', message);

  if (message.type === 'keywordDetected') {
    console.log(`Keyword "${message.keyword}" detected in user search: ${message.query}`);

    // Send the detected keyword to the backend server
    fetch('http://localhost:3001/log-keyword', {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
      },
      body: JSON.stringify({
        keyword: message.keyword,
        query: message.query,
        url: message.url || 'N/A', // Default value if URL is missing
        time: new Date().toISOString(), // Logs the current time
      }),
    })
      .then((response) => {
        if (!response.ok) {
          throw new Error(`Server error: ${response.status} ${response.statusText}`);
        }
        return response.json();
      })
      .then((data) => {
        console.log('Successfully sent to backend:', data);

        // Inform the content script that logging was successful
        sendResponse({ status: 'Keyword logged successfully', data });
      })
      .catch((error) => {
        console.error('Error sending keyword data to backend:', error);

        // Inform the content script about the error
        sendResponse({ status: 'Error', message: error.message });
      });

    // Show a notification to inform the user
    chrome.notifications.create(
      {
        type: 'basic',
        iconUrl: 'icon.png', // Path to your extension icon
        title: 'Keyword Detected',
        message: `The keyword "${message.keyword}" was found in the search query.`,
        priority: 2,
      },
      (notificationId) => {
        console.log(`Notification created with ID: ${notificationId}`);
      }
    );

    return true; // Required for asynchronous sendResponse
  } else {
    console.log('Unknown message type received');
    sendResponse({ status: 'Unknown message type' });
  }

  return true; // Required for asynchronous sendResponse
});

// Listener for notification clicks
chrome.notifications.onClicked.addListener((notificationId) => {
  console.log(`Notification with ID "${notificationId}" clicked.`);
});
