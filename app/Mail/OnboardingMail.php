<?php

namespace App\Mail;

use Illuminate\Bus\Queueable;
use Illuminate\Contracts\Queue\ShouldQueue;
use Illuminate\Mail\Mailable;
use Illuminate\Mail\Mailables\Content;
use Illuminate\Mail\Mailables\Envelope;
use Illuminate\Queue\SerializesModels;
use  App\Models\Setting;

class OnboardingMail extends Mailable implements ShouldQueue
{
    use Queueable, SerializesModels;

    public $employee;

    /**
     * Create a new message instance.
     */
    public function __construct($employee)
    {
        $this->employee = $employee;
    }

    /**
     * Email subject
     */
    public function envelope(): Envelope
    {
        $setting = Setting::latest()->first();
        return new Envelope(
            subject: 'Welcome to ' . $setting->application_name . ' – Onboarding Details'
        );
    }

    /**
     * Email content
     */
    public function content(): Content
    {

        return new Content(
            view: 'emails.onboarding',
            with: [
                'employee' => $this->employee,
            ],
        );
    }

    /**
     * Attachments (optional)
     */
    public function attachments(): array
    {
        return [];
    }
}
