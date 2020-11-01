#!/usr/bin/env python3

import datetime, email, smtplib, sys

def usage():
    print("send_reminders: Send Event Reminders to Mail Address\n")
    print("inovaction:")
    print("    send_reminders 'date|Event Title|Emails' ")
    return 1

def dow(date):
    dateobj = datetime.datetime.strptime(date, r"%Y-%m-%d")
    return dateobj .strftime("%A")


def message_template(date, title):
    message = email.message.EmailMessage()
    weekday = dow(date)
    message['Subject'] = f'Event reminder: "{title}"'
    message.set_content(f'''
    Hey! Just a quick reminder to remind you that you have an event:
    {title} on
    the {weekday} {date}.
    ''')

    return message

def send_message(message, emails):
    smtp = smtplib.SMTP('gmail.com')
    message['From'] = 'noreply@suryapradeep.in'
    for email in emails.split(','):
        del message['To']
        message['To'] = email
        smtp.send_message(message)
    smtp.quit()
    pass


def main():
    if len(sys.argv) < 2:
        return usage()

    try:
        date, title, emails = sys.argv[1].split('|')
        message = message_template(date, title)
        send_message(message, emails)
        print("Successfully sent reminders to: ", emails)
    except Exception as e:
        print("Failure to send email")
        print(e)

if __name__ == "__main__":
    sys.exit(main())
