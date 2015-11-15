<?php


namespace App\Forms\Note;

use App\Model\NoteManager;
use App\Model\PadManager;
use Nette;
use Nette\Application\UI\Form;
use Nette\Utils\ArrayHash;


class EditNoteFormFactory extends Nette\Object
{

	/** @var PadManager */
	private $padManager;

	/**
	 * @var NoteManager
	 */
	private $noteManager;

	/**
	 * EditPadFormFactory constructor.
	 * @param PadManager  $padManager
	 * @param NoteManager $noteManager
	 */
	public function __construct(PadManager $padManager, NoteManager $noteManager)
	{
		$this->padManager = $padManager;
		$this->noteManager = $noteManager;
	}

	/**
	 * @param int    $id
	 * @param string $name
	 * @param string $text
	 * @param int    $pad
	 * @return Form
	 */
	public function create($id, $name, $text, $pad)
	{
		$form = new Form;
		$form->addText('name', 'Name')
			->setDefaultValue($name)
			->setRequired('Name is required');

		$form->addTextArea('text', 'Text')
			->setDefaultValue($text)
			->setRequired('Text is required');

		$form->addSelect('pad', 'Pad', $this->padManager->findAll()->fetchPairs('id', 'name'))
			->setPrompt('Select pad')
			->setDefaultValue($pad);

		$form->addHidden('id', $id);

		$form->addSubmit('submit', 'Save');

		$form->onSuccess[] = array($this, 'formSucceeded');
		return $form;
	}

	/**
	 * @param Form      $form
	 * @param ArrayHash $values
	 */
	public function formSucceeded(Form $form, $values)
	{
		if (!$this->noteManager->update($values->id, $values->name, $values->text, $values->pad)) {
			$form->addError("Failed to edit pad");
		}
	}

}