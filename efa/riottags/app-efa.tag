<app-efa>
<h1 > </h1> 

<ul class="list-unstyled">

<li each={ value , key in conversations} class="{value.type}" > <p each={ v , k in value.messages}>{ v}</p></li>
</ul>

<form onsubmit="{sendChat}">
<input type="text" onkeyup="{setMessage}" value="{message}" required>
</form>
<script>
var self = this
self.message = ''
self.conversationId = 'start'
self.clientId = ''

self.conversations = []

self.on('mount',function(){
    self.trigger('send_chat')

})


self.setMessage = function(e){



self.message = e.target.value
self.update()
}

self.sendChat = function(e){
e.preventDefault()
if(self.message.trim().length > 0){

    self.conversations.push({ type : 'client', messages : [self.message]})
    self.trigger('send_chat')
}

}

self.on('send_chat',function(){

 var parameter = { conversation_id : self.conversationId , client_id : self.clientId, input : self.message , _csrf : csrfToken }
    $.post('/efa/conversation',parameter,function(response){
    self.conversationId = response.conversation_id
    self.clientId = response.client_id
    
    self.message = ''
    
    self.conversations.push(  { type : 'efa' , messages : response.response} )
    self.update()
    $('input').focus()
   console.log(self.conversations)
   
   self.trigger('get_profile')
    })
    self.message = ''
    self.update()
})


self.on('get_profile',function(){
 var parameter = { client_id : self.clientId , _csrf : csrfToken }
  
 $.get('/efa/profile',parameter,function(response){
 
 console.log(response)
 })


})

</script>

</app-efa>