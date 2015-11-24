<?php

namespace Notejam\Components;

use Doctrine\ORM\EntityManager;
use Nette;
use Nette\Application\UI\Form;
use Notejam\UI\FormFactory;
use Notejam\Users\UserRepository;



/**
 * Component that handles creating and processing of forgotten password.
 *
 * @method onSuccess(ForgottenPasswordControl $self) Magic method that is used to invoke the onSuccess event.
 */
class ForgottenPasswordControl extends Nette\Application\UI\Control
{

	/**
	 * @var array|callable[]
	 */
	public $onSuccess = [];

	/**
	 * @var FormFactory
	 */
	private $formFactory;

	/**
	 * @var EntityManager
	 */
	private $em;

	/**
	 * @var UserRepository
	 */
	private $userRepository;

	/**
	 * @var Nette\Mail\IMailer
	 */
	private $mailer;



	public function __construct(EntityManager $em, UserRepository $userRepository, Nette\Mail\IMailer $mailer, FormFactory $formFactory)
	{
		parent::__construct();
		$this->formFactory = $formFactory;
		$this->em = $em;
		$this->userRepository = $userRepository;
		$this->mailer = $mailer;
	}



	/**
	 * Factory method for subcomponent form instance.
	 * This factory is called internally by Nette in the component model.
	 *
	 * @return Form
	 */
	protected function createComponentForm()
	{
		$form = $this->formFactory->create();

		$form->addText('email', 'Email')
			->setRequired('%label is required')
			->addRule($form::EMAIL, 'Invalid email');

		$form->addSubmit('save', 'Get new password');
		$form->onSuccess[] = [$this, 'formSucceeded'];

		return $form;
	}



	/**
	 * Callback method, that is called once form is successfully submitted, without validation errors.
	 *
	 * @param Form $form
	 * @param Nette\Utils\ArrayHash $values
	 */
	public function formSucceeded(Form $form, $values)
	{
		if (!$user = $this->userRepository->findOneBy(['email' => $values->email])) {
			$form['email']->addError("User with given email doesn't exist");
			return;
		}

		// this is not a very secure way of getting new password
		// but it's the same way the symfony app is doing it...
		$newPassword = $user->generateRandomPassword();
		$this->em->flush();

		$message = new Nette\Mail\Message();
		$message->setSubject('Notejam password');
		$message->setFrom('noreply@notejamapp.com');
		$message->addTo($user->getEmail());
		$message->setBody("Your new password is {$newPassword}");

		$this->mailer->send($message);

		$this->onSuccess($this);
	}

}



/**
 * @see \Notejam\Components\PadsList\IPadsListControlFactory
 */
interface IForgottenPasswordControlFactory
{

	/**
	 * @return ForgottenPasswordControl
	 */
	public function create();
}
