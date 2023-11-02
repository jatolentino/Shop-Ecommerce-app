<style>
	img {
		box-shadow: 0 1px 3px rgba(0,0,0,0.12), 0 1px 2px rgba(0,0,0,0.24);
		display:block;
		margin: 1rem auto 3rem;
	}
	a.back2top {
		display: block;
		font-size: 14px;
		text-align: right;
		text-decoration: none;
		opacity: 0.7;
		cursor: pointer;
	}
	a.back2top:hover {
		text-decoration: underline;
	}
</style>

# Create an AI Chatbot

## Introduction
<style>
	#actions {
		display: flex;
		gap: 16px;
		flex-flow: row wrap;
		margin-top: 16px;
	}
	#actions > a {
		
		flex: 0 0 auto;
		background-color: #0067f4;
		color: #ffffff;
		padding: 12px 16px;
		border-radius: 4px;
		
		text-decoration: none;
		font-weight: 500;
		
		display: flex;
		gap: 8px;
		align-items: center;
	}
	#actions > a:hover {
		background-color: #003986;
	}
	#actions > a > img {
		box-shadow: none;
		display: inline-block;
		width: 20px;
		height: 20px;
		margin: 0;
		
		-webkit-filter: invert(1);
		filter: invert(1);
	}
	#actions > a > img
</style>
<div id="actions">
	<a href="https://mehagoyal.qoom.space/~/AI_Chatbot" target="_blank">
		<img src="/libs/icons/play.svg"> View Project
	</a>
	<a href="https://mehagoyal.qoom.space/edit/AI_Chatbot/README.md" target="_blank">
		<img src="/libs/icons/coding.svg">View Code
	</a>
	<a href="https://www.qoom.io/subscribe/choosecodingspace?sourceDomain=mehagoyal.qoom.space&projectPath=%2FAI_Chatbot" target="_blank">
		<img src="/libs/icons/clone.svg">Clone Project
	</a>
</div>


## Goals:
>1. Develop Python code to implement the **OpenAI API** that recieves user questions and develops a response.
>2. Use **Flask and JavaScript** to communicate data between the frontend and backend code.
>3. Design a page that displays the **popup chatbot** and allows users to open and close the popup.

## Technologies you will Learn:
>1. Submitting data and recieving generated responses using the `OPENAI` API
>2. Using `JavaScript` functions and `Flask` to send and recieve data from the page to the API
>3. The `HTML/CSS` necessary to create a popup chatbot page.

## Strategy
> 1. <a href="#top">Create a basic input and output on chatbot page</a>
> 2. <a href="#pythonapi">Access and Train AI API using Python</a> 
> 3. <a href="#javascriptconnect">Connect API functionality to the chatbot page</a> 
> 4. <a href="#cssdesign">Design chatbot popup page</a>

## Need Help?

Get help from the Qoom team and our community members. <a href="https://discord.gg/G4cFUdTq2H" target="_blank">Join Qoom Community</a>

---

<h2 id="top">1. Create basic page to display input and output</h2>

It might be difficult to build the chatbot and test its functionality without starting with a basic page for sending inputs and recieving outputs.

Let's implement a basic structure to send input and recieve ouput using HTML, and we will design the bot later using CSS.

If you haven't already, create an account on <a href="https://www.qoom.io" target="_blank">https://www.qoom.io</a> and follow along. We are using `Qoom` so that we can create a login system without writing any backend code. After creating an account, create a `New Project` and name it with a fake company name of your choosing. Then add the following `html` elements to the `<body>` elements:

```html
<body>
	
	<div class="chat-input">      
        <input type="text" name="question" placeholder="How can we help you?"/>
      <button type="submit" onclick='send()'>Submit</button>
    </div>
    
    <div id="textarea" class="chat-logs">
     </div>

</body>

```
The first div holds an input element, and a button. The input has the placeholder "How can we help you?" in order to prompt the user to ask a question. The button, with type submit and the corressponding function send, will send the user's request to the back end later on. The second div with id="textarea" is where the output will be printed.

---


<h2 id="pythonapi">2. Use Python and Open AI API to develop the backend chatbot</h2>

Most of the following work will be done in a single, new python file called app.py.

Here is the setup for the python file and API we will be using: 
```python
from flask import Flask, request, session
from random import choice
from flask import Flask, request, Response
import os
import openai
app = Flask(__name__)

openai.api_key = os.getenv('Your-Key-Variable')
completion = openai.Completion()
```
You will want to save your secret key as an env variable, whose name you will put in the place of "Your-Key-Variable"

Now, we will be adding in some training data of our own! Separate each question and answer set with a new line to indicate where each conversation ends. The start sequence and restart sequence labeled at the beginning help the API understand when to start responding and when a user has restarted the conversation.

``` python
start_sequence = """\nQoom:"""
restart_sequence = """\n\nYou:"""
#Add comments

session_prompt = """Welcome! I am QoomBot, Qoom's very own AI based chatbot. How may I help you?

	You: What do you do?
	Qoom: I am an AI tool to help you navigate the Qoom platform. 

	You: How can I create a new project? 
	Qoom: Go to your coding space and click New Project. Enter a project name and select Create. 

	You: How can I learn to code?
	Qoom: Go to qoom.io and navigate to the Tutorials page to learn how to code new projects. You can also go to your coding space and select the Qoom of the Week tab to join a workshop. 

	You: Can I get involved with the Qoom organization? 
	Qoom: Apply to Qoom's Creator Group sessions to start getting involved. 

	You: Can you build me a website? 
	Qoom: I'm afraid I'm not able to help you with that. 

	You: What should I do first?
	Qoom: You should start by creating an account. You can access tutorials, your coding space, and new opportunities. 

	You:""" #continue adding questions and answers here

stop = "\n"

```

After we add the training data, we need to write a function to take in a question and produce an answer based on the data:

```python
def ask(question, chat_log=None): #this first function recieves the question and uses the training data to return an answer
	prompt_text = f"{chat_log}{restart_sequence}: {question}{start_sequence}:"
	
	#prompt_text is reading from our original session prompt input and and looking for the start_sequence in the inputted question
	
	#the next set of lines is setting the response variable to an ouput created by the Open AI API based on the training data and specifications we provide it.
	
	response = openai.Completion.create(
		engine="davinci", 
		prompt=prompt_text, #this is recieving our prompt based on the question parameter and start sequence
		temperature=0.7, #temperature designates how creative you want the chatbot to be on a scale of 0-1
		max_tokens=300, #max_tokens states how long the answer can be
		top_p=1, #top_p is another creativity measure, but should be set to 1 when temperature is in use
		frequency_penalty=0,
		presence_penalty=0.1,
		stop=[stop],
	)
 
 story = response["choices"][0]["text"]
 return str(story) 
```
Great! We now have a function that can create an ouput for any user question. We now need to write some functions to add our response to a chatlog. We may not be using this in our basic project, but feel free to integrate the chatlog into your chatbot as a future challenge!

```python

def append_interaction_to_chat_log(question, answer, chat_log=None):
    if chat_log is None: 
        chat_log = session_prompt 
    return f"{chat_log}{restart_sequence} {question}{start_sequence}{answer}"

def root_dir():  
    return os.path.abspath(os.path.dirname(__file__))


def get_file(filename):  
    try:
        src = os.path.join(root_dir(), filename)
        return open(src).read()
    except IOError as exc:
        return str(exc)
```

We now need to create routes in flask to link our python input and output to our html page. Each route has a return value which is either a value or a Response function.

```python
app.config["SECRET_KEY"] = "generate1241235jasdaRandomstring"
@app.route("/qoombot/answer", methods=["POST"])
def qoom():
 incoming_msg = request.get_json()["question"]
 print(incoming_msg)
 chat_log = session.get("chat_log")
 return answer

@app.route("/", methods=['GET', 'POST'])
def home():
    content = get_file('index.html')
    return Response(content, mimetype="text/html")

@app.route("/style.css", methods=['GET'])
def style():
    content = get_file('style.css')
    return Response(content, mimetype="text/css")

@app.route("/script.js", methods=['GET'])
def scriptjs():
    content = get_file('script.js')
    return Response(content, mimetype="text/js")
if __name__ == "__main__":
 app.run(debug=True)
```
You can replace the string saved in ["Secret_Key"] with any random string you'd like! If your chatbot starts acting wonky, try replacing the string.

We just made a route for each of the files of code we've written in order to make sure they are included in our project. If you make any more files, add a route for them too!

<h2 id="javascriptconnect">3. Connect API functionality to the chatbot page with JavaScript</h2>

Now, let's work on JavaScript! We will add some JavaScript inside ```<script></script>``` tags on our main html page in order to send and recieve information from the API. Place your script tags inside the html body tags.

```js
<script>
    async function send() {
				
		const input = document.querySelector('input').value;
				
		const resp = await fetch('/qoombot/answer', {   // https://developer.mozilla.org/en-US/docs/Web/API/Fetch_API/Using_Fetch
			body: JSON.stringify({question: input}),  // Converting data into a string to send to server cols="15" rows="5"
			headers: { 'Content-Type': 'application/json'},				method: 'POST'
		})
				
		const text = await resp.text();
        const inp = document.createElement("div");
		const div = document.createElement("div");
   
       
        inp.innerText="You: "+ String(input) +"\n\n";
        document.querySelector('#textarea').appendChild(inp);
        div.innerText="QoomBot: "+text+"\n\n";
		document.querySelector('#textarea').appendChild(div);
        var element = document.getElementById('textarea');
        element.scrollTop = element.scrollHeight;
				
	}
  </script> 
```
A link with more information and details on async functions is included at the bottom of the page!

<a href="#top" class="back2top">Back To Top</a>

---

<h2 id="cssdesign">4.Design Chatbot with CSS</h2>

Now that all the chatbot functionality is complete, let's start designing the chatbot! We first need to include some libraries into our html. Add the following code to the bottom of your head element in the html file. Be sure to add the links in this order, or you may end up with loading errors!

```html
  <script src="https://npmcdn.com/tether@1.2.4/dist/js/tether.min.js"></script>
  <link rel='stylesheet' href='https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/4.0.0-alpha.6/css/bootstrap.min.css'>
  <link rel='stylesheet' href='https://cdnjs.cloudflare.com/ajax/libs/bootstrap-material-design/4.0.2/bootstrap-material-design.css'>
  <link rel='stylesheet' href='https://fonts.googleapis.com/icon?family=Material+Icons'>
  <link rel="stylesheet" href="style.css">
  <script src='https://cdnjs.cloudflare.com/ajax/libs/jquery/3.1.1/jquery.min.js'></script>
  <script src='https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/4.0.0-alpha.6/js/bootstrap.min.js'></script>
  <script src="script.js"></script>

```
After we include this links, let's add a more advanced html structure to our page. Replace the previous content of the body (leave the script tags as is) with the following code:

```html
  <div id="chat-circle">
        <div id="chat-overlay"></div>
		    <i class="material-icons">question_answer</i>
	</div>
	<!--The div above will be the div we design to show the button circle users will click in order to see the chatbot. The next div will be the box that appears after users click the button.-->
	
  <div class="chat-box">
    <div class="chat-box-header">
      ChatBot
      <div class="chat-box-toggle"><i class="material-icons">close</i>
      </div>
    </div>
    <!--The chatbot header will include the name of the chatbot and a close sign so that users can exit the box-->
    
    <div class="chat-box-body">
      <div class="chat-box-overlay">   
      </div>
      <div id="textarea" readonly class="chat-logs">
      </div><!--chat-log -->
    </div>
    <!--The class chat-box-body is the middle of the box, where the output will apear-->
    
    <div class="chat-input">      
        <input type="text" id="chat-input" name="question" placeholder="How can we help you?"/>
      <button type="submit" class="chat-submit" id="chat-submit" value = request onclick='send()'><i class="material-icons">send</i></button>
    </div>
    <!--This last part of the div is where the user will enter their question, so we include an input option and a send button-->
  </div>

```
Let's make a JavaScript File so that when the button is clicked, the chatbox pops up! We will name the file script.js.

```javascript
$(function() {
    $(document).delegate(".chat-btn", "click", function() {
    var value = $(this).attr("chat-value");
    var name = $(this).html();
    $("#chat-input").attr("disabled", false);
  })
  
  $("#chat-circle").click(function() {    
    $("#chat-circle").toggle('scale');
    $(".chat-box").toggle('scale');
  })
  
  $(".chat-box-toggle").click(function() {
    $("#chat-circle").toggle('scale');
    $(".chat-box").toggle('scale');
  })
  
})

```
Finally, let's add some CSS! Go step by step for each div that we outlined. Here's the code for the first div, which includes the initial circle button:

```css
html, body {
  background: #efefef;      
  height:100%;  
}

#chat-circle {
  position: fixed;
  bottom: 50px;
  right: 50px;
  background: #5A5EB9;
  width: 80px;
  height: 80px;  
  border-radius: 50%;
  padding: 28px;
  color: white;
  cursor: pointer;
  box-shadow: 0px 3px 16px 0px rgba(0, 0, 0, 0.6), 0 3px 1px -2px rgba(0, 0, 0, 0.2), 0 1px 5px 0 rgba(0, 0, 0, 0.12);
}

```
We set cursor to pointer in order to indicate when to the user that they are hovering over a button. The box shadow also helps draw attention to the button in the corner.

Great! We've completed the basic design for the circle button users will click to access the chatbot. Let's break down the second div now, which is the header, body, and input.

First, let's design the header and the response to our JavaScript toggle function.

```css

.chat-box-header {
  background: #5A5EB9;
  height:70px;
  border-top-left-radius:5px;
  border-top-right-radius:5px; 
  color:white;
  text-align:center;
  font-size:20px;
  padding-top:17px;
}

.chat-box-toggle {
  float:right;
  margin-right:15px;
  cursor:pointer;
}
```
Next, we want to design the body of the chatbot. This includes the chatlogs, which stores the previous values in the div and helps us scroll through the responses.

```css

#chat-overlay {
    background: rgba(255,255,255,0.1);
    position: absolute;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    border-radius: 50%;
    display: none;
}

.chat-box {
  display:none;
  background: #efefef;
  position:fixed;
  right:30px;
  bottom:50px;  
  width:350px;
  max-width: 85vw;
  max-height:100vh;
  border-radius:5px;  
/*   box-shadow: 0px 5px 35px 9px #464a92; */
  box-shadow: 0px 5px 35px 9px #ccc;
}

.chat-box-body {
  position: relative;  
  height:370px;  
  height:auto;
  border:1px solid #ccc;  
  overflow: hidden;
}
.chat-box-body:after {
  content: "";
  opacity: 0.1;
  top: 0;
  left: 0;
  bottom: 0;
  right: 0;
  height:100%;
  position: absolute;
  z-index: -1;   
}

.chat-logs {
  padding:15px; 
  height:370px;
  overflow-y:scroll;
}

.chat-logs::-webkit-scrollbar-track
{
	-webkit-box-shadow: inset 0 0 6px rgba(0,0,0,0.3);
  box-shadow: inset 0 0 6px rgba(0,0,0,0.3);
	background-color: #F5F5F5;
}

.chat-logs::-webkit-scrollbar
{
	width: 10px;  
	background-color: #F5F5F5;
}

.chat-logs::-webkit-scrollbar-thumb
{
	background-color: #5A5EB9;
}

@media only screen and (max-width: 500px) {
   .chat-logs {
        height:40vh;
    }
}
```
The overflow-y: scroll element allows users to scroll through past chatlogs even if they go past the size of the chatbot window.

Finally, let's design the input div! We will design both the input box and the submit button.

```css
#chat-input {
  background: #f4f7f9;
  width:100%; 
  position:relative;
  height:47px;  
  padding: 10px, 50px, 10px, 20px;
  resize:none;
  outline:none;
  border:1px solid #ccc;
  color:#888;
  border-top:none;
  border-bottom-right-radius:5px;
  border-bottom-left-radius:5px;
  overflow:hidden;  
}
.chat-input > form {
    margin-bottom: 0;
}
#chat-input::-webkit-input-placeholder { 
  color: #ccc;
}
.chat-submit {  
  position:absolute;
  bottom:3px;
  right:10px;
  background: transparent;
  box-shadow:none;
  border:none;
  border-radius:50%;
  color:#5A5EB9;
  width:35px;
  height:35px;  
}
```
The chatbox-body:after indicates the new design of the chatbox once the chatbot circle is clicked. Beforehand, the chatbox is hidden. 

Now we are done!

---

## Resources:
>1.  <a href="https://developer.mozilla.org/en-US/docs/Web/API/Fetch_API/Using_Fetch">JavaScript Async Functions/Fetch API</a> 
>2. <a href="https://codepen.io/shivapandey/pen/dWdRYM">CSS Design</a>

## Challenges:

> 1. Add profile pictures for both the user and qoombot! Try and get each response to stick to the correct side of the app window. 
> 2. Add a feature using the chatlog function in python (hint: research rendering pages instead of returning values)
>3. Add the question-answer data in a text file, add more data, and try opening the file through python.