# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.create!([{
  name: "Kylo Ren",
  email: "kylo@grailed.com",
  password: "password"
},
{
  name: "Yoda",
  email: "yoda@grailed.com",
  password: "password"
},
{
  name: "Luke Skywalker",
  email: "skywalker@grailed.com",
  password: "password"
},
{
  name: "Princess Leia",
  email: "p.leia@grailed.com",
  password: "password"
}
])

Conversation.create!([{
  seller_id: 1,
  buyer_id: 3
  },
  {
    seller_id: 2,
    buyer_id: 4
  },
  {
    seller_id: 4,
    buyer_id: 3
  },
  {
    seller_id: 2,
    buyer_id: 1
  }
])

Message.create!([{
  conversation_id: 1,
  sender_id: 1,
  recipient_id: 3,
  body: "Hello I am testing this message from Kylo Ren"
  },
  {
    conversation_id: 1,
    sender_id: 3,
    recipient_id: 1,
    body: "Hi Kylo. I am Luke Skywalker"
  },
  {
    conversation_id: 1,
    sender_id: 1,
    recipient_id: 3,
    body: "when I kill you, I will have killed the Last Jedi"
  },
  {
    conversation_id: 1,
    sender_id: 1,
    recipient_id: 3,
    body: "-Kylo Ren"
  },
  {
    conversation_id: 4,
    sender_id: 2,
    recipient_id: 1,
    body: "Kylo, people want us to dual"
  },
  {
    conversation_id: 4,
    sender_id: 2,
    recipient_id: 1,
    body: "May the foce be with you"
  },
  {
    conversation_id: 4,
    sender_id: 1,
    recipient_id: 2,
    body: "No I will not -Kylo"
  }
])
