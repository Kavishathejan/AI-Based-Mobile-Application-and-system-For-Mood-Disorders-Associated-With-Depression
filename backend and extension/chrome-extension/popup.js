document.getElementById('getKeywords').addEventListener('click', () => {
    fetch('http://localhost:3001/get-keywords')
      .then(response => response.json())
      .then(data => {
        const keywordsList = document.getElementById('keywordsList');
        keywordsList.innerHTML = ''; // Clear the current list
        data.forEach((log) => {
          const listItem = document.createElement('li');
          listItem.textContent = `${log.keyword}: "${log.query}" at ${log.time}`;
          keywordsList.appendChild(listItem);
        });
      })
      .catch(err => console.error('Error fetching keywords:', err));
  });
  
  